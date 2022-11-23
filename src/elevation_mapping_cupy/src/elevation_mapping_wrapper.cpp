#include "elevation_mapping_cupy/elevation_mapping_wrapper.hpp"

// Pybind
#include <pybind11_catkin/pybind11/eigen.h>

// PCL
#include <pcl/common/projection_matrix.h>

// ROS
#include <ros/package.h>

namespace elevation_mapping_cupy {

ElevationMappingWrapper::ElevationMappingWrapper() {}

void ElevationMappingWrapper::initialize(ros::NodeHandle& nh) {
  // Add the elevation_mapping_cupy path to sys.path
  auto threading = py::module::import("threading");
  py::gil_scoped_acquire acquire;

  auto sys = py::module::import("sys");
  auto path = sys.attr("path");
  std::string module_path = ros::package::getPath("elevation_mapping_cupy");
  module_path = module_path + "/script";
  path.attr("insert")(0, module_path);

  auto elevation_mapping = py::module::import("elevation_mapping_cupy.elevation_mapping");
  auto parameter = py::module::import("elevation_mapping_cupy.parameter");
  param_ = parameter.attr("Parameter")();
  setParameters(nh);
  map_ = elevation_mapping.attr("ElevationMap")(param_);
}

/**
 *  Load ros parameters into Parameter class.
 *  Search for the same name within the name space.
 */
void ElevationMappingWrapper::setParameters(ros::NodeHandle& nh) {
  // Get all parameters names and types.
  py::list paramNames = param_.attr("get_names")();
  py::list paramTypes = param_.attr("get_types")();
  py::gil_scoped_acquire acquire;

  // Try to find the parameter in the ros parameter server.
  // If there was a parameter, set it to the Parameter variable.
  for (int i = 0; i < paramNames.size(); i++) {
    std::string type = py::cast<std::string>(paramTypes[i]);
    std::string name = py::cast<std::string>(paramNames[i]);
    if (type == "float") {
      float param;
      if (nh.getParam(name, param)) {
        param_.attr("set_value")(name, param);
      }
    } else if (type == "str") {
      std::string param;
      if (nh.getParam(name, param)) {
        param_.attr("set_value")(name, param);
      }
    } else if (type == "bool") {
      bool param;
      if (nh.getParam(name, param)) {
        param_.attr("set_value")(name, param);
      }
    } else if (type == "int") {
      int param;
      if (nh.getParam(name, param)) {
        param_.attr("set_value")(name, param);
      }
    }
  }

  resolution_ = py::cast<float>(param_.attr("get_value")("resolution"));
  map_length_ = py::cast<float>(param_.attr("get_value")("map_length"));
  map_n_ = static_cast<int>(round(map_length_ / resolution_));
  map_length_ = resolution_ * map_n_;  // get true length after rounding
}

void ElevationMappingWrapper::input(const pcl::PointCloud<pcl::PointXYZ>::Ptr& pointCloud, const RowMatrixXd& R, const Eigen::VectorXd& t,
                                    const double positionNoise, const double orientationNoise) {
  py::gil_scoped_acquire acquire;
  RowMatrixXd points;
  pointCloudToMatrix(pointCloud, points);
  map_.attr("input")(Eigen::Ref<const RowMatrixXd>(points), Eigen::Ref<const RowMatrixXd>(R), Eigen::Ref<const Eigen::VectorXd>(t),
                     positionNoise, orientationNoise);
}

void ElevationMappingWrapper::move_to(const Eigen::Vector3d& p) {
  py::gil_scoped_acquire acquire;
  map_.attr("move_to")(Eigen::Ref<const Eigen::Vector3d>(p));
}

void ElevationMappingWrapper::clear() {
  py::gil_scoped_acquire acquire;
  map_.attr("clear")();
}

bool ElevationMappingWrapper::exists_layer(const std::string& layerName) {
  py::gil_scoped_acquire acquire;
  return py::cast<bool>(map_.attr("exists_layer")(layerName));
}

void ElevationMappingWrapper::get_layer_data(const std::string& layerName, RowMatrixXf& map) {
  py::gil_scoped_acquire acquire;
  map = RowMatrixXf(map_n_, map_n_);
  map_.attr("get_map_with_name_ref")(layerName, Eigen::Ref<RowMatrixXf>(map));
}

void ElevationMappingWrapper::get_grid_map(grid_map::GridMap& gridMap, const std::vector<std::string>& requestLayerNames) {
  std::vector<std::string> basicLayerNames;
  std::vector<std::string> layerNames = requestLayerNames;
  std::vector<int> selection;
  for (const auto& layerName : layerNames) {
    if (layerName == "elevation") {
      basicLayerNames.push_back("elevation");
    }
  }
  RowMatrixXd pos(1, 3);
  py::gil_scoped_acquire acquire;
  map_.attr("get_position")(Eigen::Ref<RowMatrixXd>(pos));
  grid_map::Position position(pos(0, 0), pos(0, 1));
  grid_map::Length length(map_length_, map_length_);
  gridMap.setGeometry(length, resolution_, position);
  std::vector<Eigen::MatrixXf> maps;

  for (const auto& layerName : layerNames) {
    RowMatrixXf map(map_n_, map_n_);
    map_.attr("get_map_with_name_ref")(layerName, Eigen::Ref<RowMatrixXf>(map));
    gridMap.add(layerName, map);
  }
  gridMap.setBasicLayers(basicLayerNames);
}


void ElevationMappingWrapper::initializeWithPoints(std::vector<Eigen::Vector3d>& points, std::string method) {
  RowMatrixXd points_m(points.size(), 3);
  int i = 0;
  for (auto& p : points) {
    points_m(i, 0) = p.x();
    points_m(i, 1) = p.y();
    points_m(i, 2) = p.z();
    i++;
  }
  py::gil_scoped_acquire acquire;
  map_.attr("initialize_map")(Eigen::Ref<const RowMatrixXd>(points_m), method);
}

void ElevationMappingWrapper::pointCloudToMatrix(const pcl::PointCloud<pcl::PointXYZ>::Ptr& pointCloud, RowMatrixXd& points) {
  points = RowMatrixXd(pointCloud->size(), 3);
  for (unsigned int i = 0; i < pointCloud->size(); ++i) {
    const auto& point = pointCloud->points[i];
    points(i, 0) = static_cast<double>(point.x);
    points(i, 1) = static_cast<double>(point.y);
    points(i, 2) = static_cast<double>(point.z);
  }
}

void ElevationMappingWrapper::update_variance() {
  py::gil_scoped_acquire acquire;
  map_.attr("update_variance")();
}

void ElevationMappingWrapper::update_time() {
  py::gil_scoped_acquire acquire;
  map_.attr("update_time")();
}

}  // namespace elevation_mapping_cupy
