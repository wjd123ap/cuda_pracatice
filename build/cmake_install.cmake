# Install script for directory: /home/hur/robot_sp/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/hur/robot_sp/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/hur/robot_sp/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/hur/robot_sp/install" TYPE PROGRAM FILES "/home/hur/robot_sp/build/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/hur/robot_sp/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/hur/robot_sp/install" TYPE PROGRAM FILES "/home/hur/robot_sp/build/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/hur/robot_sp/install/setup.bash;/home/hur/robot_sp/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/hur/robot_sp/install" TYPE FILE FILES
    "/home/hur/robot_sp/build/catkin_generated/installspace/setup.bash"
    "/home/hur/robot_sp/build/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/hur/robot_sp/install/setup.sh;/home/hur/robot_sp/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/hur/robot_sp/install" TYPE FILE FILES
    "/home/hur/robot_sp/build/catkin_generated/installspace/setup.sh"
    "/home/hur/robot_sp/build/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/hur/robot_sp/install/setup.zsh;/home/hur/robot_sp/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/hur/robot_sp/install" TYPE FILE FILES
    "/home/hur/robot_sp/build/catkin_generated/installspace/setup.zsh"
    "/home/hur/robot_sp/build/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/hur/robot_sp/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/hur/robot_sp/install" TYPE FILE FILES "/home/hur/robot_sp/build/catkin_generated/installspace/.rosinstall")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/hur/robot_sp/build/gtest/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_core/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_sdf/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_octomap/cmake_install.cmake")
  include("/home/hur/robot_sp/build/elevation_map_msgs/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_msgs/cmake_install.cmake")
  include("/home/hur/robot_sp/build/roscuda_basic/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_cv/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_ros/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_filters/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_loader/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_visualization/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_pcl/cmake_install.cmake")
  include("/home/hur/robot_sp/build/elevation_mapping_cupy/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_rviz_plugin/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_demos/cmake_install.cmake")
  include("/home/hur/robot_sp/build/grid_map/grid_map_costmap_2d/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/examples/zed_ar_track_alvar_example/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/tutorials/zed_depth_sub_tutorial/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/zed_display_rviz/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/zed_examples/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-wrapper/zed-ros-interfaces/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/rviz-plugin-zed-od/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/examples/zed_multicamera_example/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/examples/zed_nodelet_example/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-wrapper/zed_nodelets/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/tutorials/zed_obj_det_sub_tutorial/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-wrapper/zed_ros/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/examples/zed_rtabmap_example/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/tutorials/zed_sensors_sub_tutorial/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/tests/zed_sync_test/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/tutorials/zed_tracking_sub_tutorial/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-examples/tutorials/zed_video_sub_tutorial/cmake_install.cmake")
  include("/home/hur/robot_sp/build/zed-ros-wrapper/zed_wrapper/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/hur/robot_sp/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
