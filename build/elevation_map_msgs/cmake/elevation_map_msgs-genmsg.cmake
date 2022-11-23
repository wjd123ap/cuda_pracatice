# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "elevation_map_msgs: 1 messages, 1 services")

set(MSG_I_FLAGS "-Ielevation_map_msgs:/home/hur/robot_sp/src/elevation_map_msgs/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(elevation_map_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" NAME_WE)
add_custom_target(_elevation_map_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "elevation_map_msgs" "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" NAME_WE)
add_custom_target(_elevation_map_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "elevation_map_msgs" "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" "geometry_msgs/Point:std_msgs/Header:geometry_msgs/PointStamped"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/elevation_map_msgs
)

### Generating Services
_generate_srv_cpp(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/elevation_map_msgs
)

### Generating Module File
_generate_module_cpp(elevation_map_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/elevation_map_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(elevation_map_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(elevation_map_msgs_generate_messages elevation_map_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_cpp _elevation_map_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_cpp _elevation_map_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(elevation_map_msgs_gencpp)
add_dependencies(elevation_map_msgs_gencpp elevation_map_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS elevation_map_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/elevation_map_msgs
)

### Generating Services
_generate_srv_eus(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/elevation_map_msgs
)

### Generating Module File
_generate_module_eus(elevation_map_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/elevation_map_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(elevation_map_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(elevation_map_msgs_generate_messages elevation_map_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_eus _elevation_map_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_eus _elevation_map_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(elevation_map_msgs_geneus)
add_dependencies(elevation_map_msgs_geneus elevation_map_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS elevation_map_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/elevation_map_msgs
)

### Generating Services
_generate_srv_lisp(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/elevation_map_msgs
)

### Generating Module File
_generate_module_lisp(elevation_map_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/elevation_map_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(elevation_map_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(elevation_map_msgs_generate_messages elevation_map_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_lisp _elevation_map_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_lisp _elevation_map_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(elevation_map_msgs_genlisp)
add_dependencies(elevation_map_msgs_genlisp elevation_map_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS elevation_map_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/elevation_map_msgs
)

### Generating Services
_generate_srv_nodejs(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/elevation_map_msgs
)

### Generating Module File
_generate_module_nodejs(elevation_map_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/elevation_map_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(elevation_map_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(elevation_map_msgs_generate_messages elevation_map_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_nodejs _elevation_map_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_nodejs _elevation_map_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(elevation_map_msgs_gennodejs)
add_dependencies(elevation_map_msgs_gennodejs elevation_map_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS elevation_map_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/elevation_map_msgs
)

### Generating Services
_generate_srv_py(elevation_map_msgs
  "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/elevation_map_msgs
)

### Generating Module File
_generate_module_py(elevation_map_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/elevation_map_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(elevation_map_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(elevation_map_msgs_generate_messages elevation_map_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/msg/Statistics.msg" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_py _elevation_map_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hur/robot_sp/src/elevation_map_msgs/srv/Initialize.srv" NAME_WE)
add_dependencies(elevation_map_msgs_generate_messages_py _elevation_map_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(elevation_map_msgs_genpy)
add_dependencies(elevation_map_msgs_genpy elevation_map_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS elevation_map_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/elevation_map_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/elevation_map_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(elevation_map_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/elevation_map_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/elevation_map_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(elevation_map_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/elevation_map_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/elevation_map_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(elevation_map_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/elevation_map_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/elevation_map_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(elevation_map_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/elevation_map_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/elevation_map_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/elevation_map_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(elevation_map_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
