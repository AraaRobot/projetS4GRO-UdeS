#!/bin/bash
set -e

# Source ROS installation
if [ -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]; then
  source "/opt/ros/${ROS_DISTRO}/setup.bash"
fi

# If workspace overlay exists, source it too
WS_SETUP="/home/${USERNAME}/scorpius_ws/install/setup.bash"
if [ -f "${WS_SETUP}" ]; then
  source "${WS_SETUP}"
fi

# Execute whatever was passed to the container
exec "$@"
