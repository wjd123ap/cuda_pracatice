import os
import numpy as np
import threading
import subprocess
from .map_initializer import MapInitializer
from .parameter import Parameter
from .custom_kernels import add_points_kernel
from .custom_kernels import average_map_kernel
import cupy as cp
import time
xp = cp
# Use asynchronous stream ordered memory
cp.cuda.set_allocator(cp.cuda.MemoryAsyncPool().malloc)

# Create a custom stream
s = cp.cuda.Stream()

# This would allocate memory asynchronously on stream s
with s:
    pass
class ElevationMap(object):
    """
    Core elevation mapping class.
    """

    def __init__(self, param: Parameter):
        self.param = param

        self.resolution = param.resolution
        self.center = xp.array([0, 0, 0], dtype=xp.float32)
        self.map_length = param.map_length
        # +2 is a border for outside map
        self.cell_n = int(round(self.map_length / self.resolution))+2

        self.map_lock = threading.Lock()

        # layers: elevation, variance, is_valid, traversability, time, upper_bound, is_upper_bound
        self.elevation_map = xp.zeros((5, self.cell_n, self.cell_n),dtype=xp.float32)
        self.layer_names = [
            "elevation",
            "variance",
            "is_valid",
            "time",
            "max_height"
        ]
        # Initial variance
        self.initial_variance = param.initial_variance
        self.elevation_map[1] += self.initial_variance
        # overlap clearance
        cell_range = int(self.param.overlap_clear_range_xy / self.resolution)
        cell_range = np.clip(cell_range, 0, self.cell_n)
        self.cell_min = self.cell_n // 2 - cell_range // 2
        self.cell_max = self.cell_n // 2 + cell_range // 2
        self.compile_kernels()


        self.map_initializer = MapInitializer(self.initial_variance, param.initialized_variance, xp=cp, method="points")

    def clear(self):
        with self.map_lock:
            self.elevation_map *= 0.0
            # Initial variance
            self.elevation_map[1] += self.initial_variance

    def get_position(self, position):

        self.center[0:2]=xp.around(self.center[0:2],2)

        position[0][:] = xp.asnumpy(self.center)
    def pad_value(self, x, shift_value, idx=None, value=0.0):
        if idx is None:
            if shift_value[0] > 0:
                x[:, : , :shift_value[0]] = value
            elif shift_value[0] < 0:
                x[:,  :, shift_value[0]:] = value
            if shift_value[1] > 0:
                x[:, :shift_value[1], : ] = value
            elif shift_value[1] < 0:
                x[:, shift_value[1] :, :] = value
        else:
            if shift_value[0] > 0:
                x[idx, : , :shift_value[0]] = value
            elif shift_value[0] < 0:
                x[idx,  :, shift_value[0]:] = value
            if shift_value[1] > 0:
                x[idx, :shift_value[1], : ] = value
            elif shift_value[1] < 0:
                x[idx, shift_value[1] :, :] = value


    def shift_map_xy(self, delta_pixel):
        shift_value = delta_pixel.astype(cp.int_)
        if cp.abs(shift_value).sum() == 0:
            return
        with self.map_lock:
            self.elevation_map = cp.roll(self.elevation_map, shift_value, axis=(1,))
            self.pad_value(self.elevation_map, shift_value, value=0.0)
            self.pad_value(self.elevation_map, shift_value, idx=1, value=self.initial_variance)

    def shift_map_z(self, delta_z):
        with self.map_lock:
            # elevation
            self.elevation_map[0] += delta_z

    def move(self, delta_position):
        # Shift map using delta position.
        delta_position = xp.asarray(delta_position)
        delta_pixel = xp.round(delta_position[:2] / self.resolution)
        delta_position_xy = delta_pixel * self.resolution
        self.center[:2] += xp.asarray(delta_position_xy)
        self.center[2] += xp.asarray(delta_position[2])
        self.shift_map_xy(delta_pixel)
        self.shift_map_z(-delta_position[2])

    def move_to(self, position):
        # Shift map to the center of robot.

        position = xp.asarray(position,dtype=cp.float32)
        delta = position - self.center
        delta_pixel = xp.around(delta[:2] / self.resolution)
        delta_xy = delta_pixel * self.resolution
        self.center[:2] += delta_xy
        self.center[2] += delta[2]
        self.shift_map_xy(-delta_pixel)
        self.shift_map_z(-delta[2])

    def compile_kernels(self):
        # Compile custom cuda kernels.
        self.new_map = cp.zeros((4, self.cell_n, self.cell_n),dtype=xp.float32)
        self.add_points_kernel = add_points_kernel(
            self.resolution,
            self.cell_n,
            self.cell_n,
            self.param.sensor_noise_factor,
            self.param.mahalanobis_thresh,
            self.param.increaseHeightAlpha,
            self.param.outlier_variance,
            self.param.wall_num_thresh,
            self.param.multiHeightNoise,
            self.param.max_ray_length,
            self.param.cleanup_step,
            self.param.min_valid_distance,
            self.param.max_height_range,
            self.param.cleanup_cos_thresh,
            self.param.ramped_height_range_a,
            self.param.ramped_height_range_b,
            self.param.ramped_height_range_c,
            self.param.enable_edge_sharpen,
            self.param.enable_visibility_cleanup,
        )
        self.average_map_kernel = average_map_kernel(
            self.cell_n, self.cell_n, self.param.max_variance, self.initial_variance,self.param.wall_num_thresh
        )


    def shift_translation_to_map_center(self, t):
        t -= self.center

    def update_map_with_kernel(self, points, R, t, position_noise, orientation_noise):
        self.new_map *= 0.0

        with self.map_lock:
            #self.shift_translation_to_map_center(t)
            self.add_points_kernel(
                points.astype(xp.float16),
                cp.array([0.0],dtype=xp.float16),
                cp.array([0.0],dtype=xp.float16),
                R.astype(xp.float16),
                t.astype(xp.float16),
                self.elevation_map,
                self.new_map,
                size=(points.shape[0]),
            )

            self.average_map_kernel(self.new_map, self.elevation_map, size=(self.cell_n * self.cell_n))
            if self.param.enable_overlap_clearance:
                self.clear_overlap_map(t)

    def clear_overlap_map(self, t):
        # Clear overlapping area around center
        height_min = t[2] - self.param.overlap_clear_range_z
        height_max = t[2] + self.param.overlap_clear_range_z
        near_map = self.elevation_map[:, self.cell_min : self.cell_max, self.cell_min : self.cell_max]
        valid_idx = ~cp.logical_or(near_map[0] < height_min, near_map[0] > height_max)
        near_map[0] = cp.where(valid_idx, near_map[0], 0.0)
        near_map[1] = cp.where(valid_idx, near_map[1], self.initial_variance)
        near_map[2] = cp.where(valid_idx, near_map[2], 0.0)

        self.elevation_map[:, self.cell_min : self.cell_max, self.cell_min : self.cell_max] = near_map

    def update_variance(self):
        self.elevation_map[1] += self.param.time_variance * self.elevation_map[2]

    def update_time(self):
        self.elevation_map[3] += self.param.time_interval


    def input(self, raw_points, R, t, position_noise, orientation_noise):
        # Update elevation map using point cloud input.
        atime=time.time()
        raw_points = cp.asarray(raw_points)

        raw_points = raw_points[cp.isfinite(raw_points).any(axis=1)]
        self.update_map_with_kernel(raw_points, cp.asarray(R), cp.asarray(t), position_noise, orientation_noise)
        btime=time.time()
        print(btime-atime)

    def process_map_for_publish(self, input_map, fill_nan=False, add_z=False, xp=cp):
        m = input_map.copy()
        if fill_nan:
            m = xp.where(self.elevation_map[2] > 0.5, m, xp.nan)
        if add_z:
            m = m + self.center[2]
        return m[1:-1, 1:-1]

    def get_elevation(self):
        return self.process_map_for_publish(self.elevation_map[0], fill_nan=True, add_z=True)#이거 손봐야될듯

    def get_variance(self):
        return self.process_map_for_publish(self.elevation_map[1], fill_nan=False, add_z=False)

    def get_time(self):
        return self.process_map_for_publish(self.elevation_map[3], fill_nan=False, add_z=False)

    def xp_of_array(self, array):
        if type(array) == cp.ndarray:
            return cp
        elif type(array) == np.ndarray:
            return np

    def copy_to_cpu(self, array, data, stream=None):
        if type(array) == np.ndarray:
            data[...] = array.astype(np.float32)
        elif type(array) == cp.ndarray:
            if stream is not None:
                data[...] = cp.asnumpy(array.astype(np.float32), stream=stream)
            else:
                data[...] = cp.asnumpy(array.astype(np.float32))

    def exists_layer(self, name):
        if name in self.layer_names:
            return True

        else:
            return False

    def get_map_with_name_ref(self, name, data):
        use_stream = True
        xp = cp
        with self.map_lock:
            if name == "elevation":
                m = self.get_elevation()
                use_stream = False
            elif name == "variance":
                m = self.get_variance()
            elif name == "time":
                m = self.get_time()
            else:
                # print("Layer {} is not in the map".format(name))
                return
        m=m.T
        m = xp.flip(m, 0)
        m = xp.flip(m, 1)

        if use_stream:
            stream = cp.cuda.Stream(non_blocking=False)
        else:
            stream = None
        self.copy_to_cpu(m, data, stream=stream)


    def transform_to_map_index(points, center, cell_n, resolution):
        indices = ((points - center.reshape(1, 2)) / resolution + cell_n / 2).astype(cp.int)
        return indices

    def initialize_map(self, points, method="cubic"):
        self.clear()
        with self.map_lock:
            points = cp.asarray(points)
            indices = self.transform_to_map_index(points[:, :2], self.center[:2], self.cell_n, self.resolution)
            points[:, :2] = indices.astype(points.dtype)
            points[:, 2] -= self.center[2]
            self.map_initializer(self.elevation_map, points, method)


if __name__ == "__main__":
    #  Test script for profiling.
    #  $ python -m cProfile -o profile.stats elevation_mapping.py
    #  $ snakeviz profile.stats
    import matplotlib.pyplot as plt
    from mpl_toolkits import mplot3d

    xp.random.seed(123)
    points = xp.random.rand(100000, 3)
    R = xp.array([[1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0]],dtype=xp.float32)
    t = xp.array([0.0,0.0,0.3],dtype=xp.float32)
    param = Parameter()
    elevation = ElevationMap(param)
    layers = ["elevation", "variance", "inpaint"]
    data = np.zeros((elevation.cell_n - 2, elevation.cell_n - 2), dtype=np.float32)
    #elevation.input(points, R, t, 0, 0)
    x = np.linspace(-0.41, 0.41, 82)
    y = np.linspace(-0.41, 0.41, 82)
    X, Y = np.meshgrid(x, y)
    x_1 = cp.linspace(0.25, 0.02, 25,dtype=cp.float32)
    y_1 = cp.linspace(0.10, 0.02, 25,dtype=cp.float32)
    X_1, Y_1 = cp.meshgrid(x_1, y_1)

    #X_1= X_1.
    z=cp.zeros((25,25),dtype=cp.float32)-0.1
    z= cp.dstack((X_1,Y_1,z)).reshape((625,3))

    elevation.input(z, R, t, 0, 0)
    for i in range(6):
        i=i+1

        pos = cp.array([0,  0.1*i, 0])
        Z=cp.asnumpy(elevation.elevation_map[0])
        fig = plt.figure()
        ax = fig.gca(projection='3d')
        surf = ax.plot_surface(X,Y,Z,cmap='coolwarm',linewidth=0,antialiased=False)
        wire = ax.plot_wireframe(X,Y,Z,color='r',linewidth=0.1)
        fig.colorbar(surf,shrink=0.5,aspect=5)
        fig.tight_layout()
        plt.show()

        print(elevation.elevation_map[0])
        #print(cp.nonzero(elevation.elevation_map[0]))
        elevation.move_to(pos)
        elevation.get_map_with_name_ref("elevation", data)
