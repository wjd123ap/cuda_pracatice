execute_process(COMMAND "/home/hur/robot_sp/build/elevation_mapping_cupy/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/hur/robot_sp/build/elevation_mapping_cupy/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
