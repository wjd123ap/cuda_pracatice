import cupy as cp
import string


def map_utils(resolution,
    width,
    height,
    sensor_noise_factor,
    min_valid_distance,
    max_height_range,
    ramped_height_range_a,
    ramped_height_range_b,
    ramped_height_range_c,
):
  util_preamble = string.Template(
    """
    __device__ int clamp(int x,int min_x, int max_x){
      return max(min(x, max_x),min_x);
    }
    __device__ int get_x_idx(float16 x, float16 center) {
            int i = (x - center) / ${resolution} + 0.5 * ${width};
            return i;
    }
    __device__ int get_y_idx(float16 y, float16 center) {
        int i = (y - center) / ${resolution} + 0.5 * ${height};
        return i;
    }
    __device__ bool is_inside(int idx) {
        int idx_x = idx / ${width};
        int idx_y = idx % ${width};
        if (idx_x == 0 || idx_x == ${width} - 1||idx_y == 0 || idx_y == ${height} - 1) {
            return false;
        }
        return true;
    }
    __device__ int get_idx(float16 x, float16 y, float16 center_x, float16 center_y) {
        int idx_x = clamp(get_x_idx(x, center_x), 0.0, ${width} - 1);
        int idx_y = clamp(get_y_idx(y, center_y), 0.0, ${height} - 1);
        return ${width} * idx_y + idx_x;
    }
    __device__ int get_map_idx(int idx, int layer_n) {
    const int layer = ${width} * ${height};
    return layer * layer_n + idx;
    }
    __device__ float transform_p(float16 x, float16 y, float16 z,
                                  float16 r0, float16 r1, float16 r2, float16 t) {
        return r0 * x + r1 * y + r2 * z + t;
    }
    __device__ float z_noise(float16 z){
        return ${sensor_noise_factor} * z * z;
    }
    __device__ float point_sensor_distance(float16 x, float16 y, float16 z,
                                        float16 sx, float16 sy, float16 sz) {
    float d = (x - sx) * (x - sx) + (y - sy) * (y - sy) + (z - sz) * (z - sz);
    return d;
    }
    __device__ bool is_valid(float16 x, float16 y, float16 z,
                        float16 sx, float16 sy, float16 sz) {
    float d = point_sensor_distance(x, y, z, sx, sy, sz);
    float dxy = max(sqrt(x * x + y * y) - ${ramped_height_range_b}, 0.0);
    if (d < ${min_valid_distance} * ${min_valid_distance}||(z - sz > dxy * ${ramped_height_range_a} + ${ramped_height_range_c} )|| (z - sz > ${max_height_range})) {
        return false;
    }
    else {
        return true;
    }
    }
    __device__ float ray_vector(float16 tx, float16 ty, float16 tz,
                            float16 px, float16 py, float16 pz,
                            float16& rx, float16& ry, float16& rz){
    float16 vx = px - tx;
    float16 vy = py - ty;
    float16 vz = pz - tz;
    float16 norm = sqrt(vx * vx + vy * vy + vz * vz);
    if (norm > 0) {
        rx = vx / norm;
        ry = vy / norm;
        rz = vz / norm;
    }
    else {
        rx = 0;
        ry = 0;
        rz = 0;
    }
    return norm;
    }
    __device__ float inner_product(float16 x1, float16 y1, float16 z1,
                                    float16 x2, float16 y2, float16 z2) {
        float product = (x1 * x2 + y1 * y2 + z1 * z2);
        return product;
    }

    """
  ).substitute(
        resolution=resolution,
        width=width,
        height=height,
        sensor_noise_factor=sensor_noise_factor,
        min_valid_distance=min_valid_distance,
        max_height_range=max_height_range,
        ramped_height_range_a=ramped_height_range_a,
        ramped_height_range_b=ramped_height_range_b,
        ramped_height_range_c=ramped_height_range_c,
    )
  return util_preamble
def add_points_kernel(
    resolution,
    width,
    height,
    sensor_noise_factor,
    mahalanobis_thresh,
    increaseHeightAlpha,
    outlier_variance,
    wall_num_thresh,
    multiHeightNoise,
    max_ray_length,
    cleanup_step,
    min_valid_distance,
    max_height_range,
    cleanup_cos_thresh,
    ramped_height_range_a,
    ramped_height_range_b,
    ramped_height_range_c,
    enable_edge_shaped=True,
    enable_visibility_cleanup=True,
):

    add_points_kernel = cp.ElementwiseKernel(
        in_params="raw float16 p, raw float16 center_x, raw float16 center_y, raw float16 R, raw U t",
        out_params="raw F map, raw T newmap",
        preamble=map_utils(
            resolution,
            width,
            height,
            sensor_noise_factor,
            min_valid_distance,
            max_height_range,
            ramped_height_range_a,
            ramped_height_range_b,
            ramped_height_range_c,
        ),
        operation=string.Template(
        """

        float16 rx = p[i * 3];
        float16 ry = p[i * 3 + 1];
        float16 rz = p[i * 3 + 2];
        F x = transform_p(rx, ry, rz, R[0], R[1], R[2], t[0]);
        F y = transform_p(rx, ry, rz, R[3], R[4], R[5], t[1]);
        F z = transform_p(rx, ry, rz, R[6], R[7], R[8], t[2]);
        F v = z_noise(rz);
        int idx = get_idx(x, y, center_x[0], center_y[0]);
        if (is_valid(x, y, z, t[0], t[1], t[2])||is_inside(idx)) {

            F map_h = map[get_map_idx(idx, 0)];
            F map_v = map[get_map_idx(idx, 1)];
            U num_points = newmap[get_map_idx(idx, 4)];
            if (fabs(map_h - z)/(sqrt(map_v))> ${mahalanobis_thresh}) {
                if(map[get_map_idx(idx, 1)]<=0.05&&map_h>z){
                // Ignore point if measurement is from the same point cloud
                }
                else{
                atomicAdd(&map[get_map_idx(idx, 0)],${multiHeightNoise});
                }
            }
            else {
                // continue
                T new_h = (map_h * v + z * map_v) / (map_v + v);
                T new_v = (map_v * v) / (map_v + v);
                atomicAdd(&newmap[get_map_idx(idx, 0)], new_h);
                atomicAdd(&newmap[get_map_idx(idx, 1)], new_v);
                atomicAdd(&newmap[get_map_idx(idx, 2)], 1.0);
                // is Valid
                map[get_map_idx(idx, 2)] = 1;
                // Time layer
                map[get_map_idx(idx, 3)] = 0.0;
                // Upper bound


                }

            }
        if (${enable_visibility_cleanup}) {

            float16 ray_x, ray_y, ray_z;
            float16 ray_length = ray_vector(t[0], t[1], t[2], x, y, z, ray_x, ray_y, ray_z);
            ray_length = min(ray_length, (float16)${max_ray_length});
            int last_nidx = -1;
            for (float16 s=${ray_step}; s < ray_length; s+=${ray_step}) {
                // iterate through ray
                F nx = t[0] + ray_x * s;
                F ny = t[1] + ray_y * s;
                F nz = t[2] + ray_z * s;
                int nidx = get_idx(nx, ny, center_x[0], center_y[0]);
                if (last_nidx == nidx||!is_inside(nidx)) {continue;}  // Skip if we're still in the same cell
                else {last_nidx = nidx;}

                F nmap_h = map[get_map_idx(nidx, 0)];
                F nmap_v = map[get_map_idx(nidx, 1)];
                F nmap_valid = map[get_map_idx(nidx, 2)];
                // traversability
                // Time layer
                U non_updated_t = map[get_map_idx(nidx, 3)];
                // If point is close or is farther away than ray length, skip.
                float16 d = (x - nx) * (x - nx) + (y - ny) * (y - ny) + (z - nz) * (z - nz);
                if (d < 0.1 || !is_valid(x, y, z, t[0], t[1], t[2])||nmap_valid < 0.5||non_updated_t < 0.5) {continue;}
                // If invalid, do upper bound check, then skip

                // If updated recently, skip

              }
          }
        """
        ).substitute(
            mahalanobis_thresh=mahalanobis_thresh,
            increaseHeightAlpha=increaseHeightAlpha,
            outlier_variance=outlier_variance,
            wall_num_thresh=wall_num_thresh,
            multiHeightNoise=multiHeightNoise,
            ray_step=resolution / 2**0.5,
            max_ray_length=max_ray_length,
            cleanup_step=cleanup_step,
            cleanup_cos_thresh=cleanup_cos_thresh,
            enable_edge_shaped=int(enable_edge_shaped),
            enable_visibility_cleanup=int(enable_visibility_cleanup),
        ),
        name="add_points_kernel",
    )
    return add_points_kernel
def average_map_kernel(width, height, max_variance, initial_variance,wall_num_thresh):
    average_map_kernel = cp.ElementwiseKernel(
        in_params="raw F newmap",
        out_params="raw F map",
        preamble=string.Template(
            """
            __device__ int get_map_idx(int idx, int layer_n) {
                const int layer = ${width} * ${height};
                return layer * layer_n + idx;
            }
            """
        ).substitute(width=width, height=height),
        operation=string.Template(
            """
            F h = map[get_map_idx(i, 0)];
            F v = map[get_map_idx(i, 1)];
            F valid = map[get_map_idx(i, 2)];
            F new_h = newmap[get_map_idx(i, 0)];
            F new_v = newmap[get_map_idx(i, 1)];
            F new_cnt = newmap[get_map_idx(i, 2)];
            if (new_cnt > 0) {
                if (new_v / new_cnt > ${max_variance}) {
                    map[get_map_idx(i, 0)] = 0;
                    map[get_map_idx(i, 1)] = ${initial_variance};
                    map[get_map_idx(i, 2)] = 0;
                }
                else {
                    map[get_map_idx(i, 0)] = new_h / new_cnt;
                    map[get_map_idx(i, 1)] = new_v / new_cnt;
                    map[get_map_idx(i, 2)] = 1;

                    if (new_cnt>${wall_num_thresh}){
                        map[get_map_idx(i, 0)]=map[get_map_idx(i, 0)]+map[get_map_idx(i, 1)];
                    }

                }
            }
            if (valid < 0.5) {
                map[get_map_idx(i, 0)] = 0;
                map[get_map_idx(i, 1)] = ${initial_variance};
                map[get_map_idx(i, 2)] = 0;
            }
            """
        ).substitute(max_variance=max_variance, initial_variance=initial_variance,wall_num_thresh=wall_num_thresh),
        name="average_map_kernel",
    )
    return average_map_kernel

#def move_map_kernal(width, height,straight_cdf,diagonal_cdf):
    move_map_kernal=cp.ElementwiseKernel(
        in_params="raw U map",
        out_params="raw U map",
        preamble=string.Template(
            """
            __device__ int get_map_idx(int idx, int layer_n) {
                const int layer = ${width} * ${height};
                return layer * layer_n + idx;
            }
            """
        ).substitute(width=width, height=height),
        operation=string.Template(
            """
                U h = map[get_map_idx(i, 0)];
                U v = map[get_map_idx(i, 1)];

            """
        ).substitute(straight_cdf=straight_cdf,diagonal_cdf=diagonal_cdf),
        name="move_map_kernal"
    )
    return move_map_kernal
