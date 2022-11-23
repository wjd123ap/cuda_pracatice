#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/hur/robot_sp/src/elevation_mapping_cupy"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/hur/robot_sp/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/hur/robot_sp/install/lib/python3/dist-packages:/home/hur/robot_sp/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/hur/robot_sp/build" \
    "/usr/bin/python3" \
    "/home/hur/robot_sp/src/elevation_mapping_cupy/setup.py" \
     \
    build --build-base "/home/hur/robot_sp/build/elevation_mapping_cupy" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/hur/robot_sp/install" --install-scripts="/home/hur/robot_sp/install/bin"
