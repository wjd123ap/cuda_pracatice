from dataclasses import dataclass
import pickle
import numpy as np
import os


@dataclass
class Parameter:
    resolution: float = 0.01

    map_length: float = 0.8
    sensor_noise_factor: float = 0.02
    mahalanobis_thresh: float = 2.0
    outlier_variance: float = 0.01
    time_variance: float = 0.01
    time_interval: float = 0.1
    increaseHeightAlpha: float = 0.99
    max_variance: float = 2.0
    multiHeightNoise: float = 0.00005
    wall_num_thresh: float = 100

    max_ray_length: float = 2.0
    cleanup_step: float = 0.01
    cleanup_cos_thresh: float = 0.5
    min_valid_distance: float = 0.01
    max_height_range: float = 1.0
    ramped_height_range_a: float = 0.3
    ramped_height_range_b: float = 1.0
    ramped_height_range_c: float = 1.0

    safe_thresh: float = 0.5
    safe_min_thresh: float = 0.5
    max_unsafe_n: int = 20

    min_filter_size: int = 5
    min_filter_iteration: int = 3

    overlap_clear_range_xy: float = 4.0
    overlap_clear_range_z: float = 2.0

    enable_edge_sharpen: bool = True
    enable_visibility_cleanup: bool = True
    enable_overlap_clearance: bool = True
    use_only_above_for_upper_bound: bool = True
    use_chainer: bool = True
    position_noise_thresh: float = 0.1
    orientation_noise_thresh: float = 0.1

    plugin_config_file: str = "config/plugin_config.yaml"
    weight_file: str = "config/weights.dat"

    initial_variance: float = 1000.0
    initialized_variance: float = 1000.0
    w1: np.ndarray = np.zeros((4, 1, 3, 3))
    w2: np.ndarray = np.zeros((4, 1, 3, 3))
    w3: np.ndarray = np.zeros((4, 1, 3, 3))
    w_out: np.ndarray = np.zeros((1, 12, 1, 1))

    def get_names(self):
        return list(self.__annotations__.keys())

    def get_types(self):
        return [v.__name__ for v in self.__annotations__.values()]

    def set_value(self, name, value):
        setattr(self, name, value)

    def get_value(self, name):
        return getattr(self, name)


if __name__ == "__main__":
    param = Parameter()
    print(param)
    print(param.resolution)
    param.set_value("resolution", 0.1)
    print(param.resolution)

    print("names ", param.get_names())
    print("types ", param.get_types())
