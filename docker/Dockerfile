ARG ROS_DISTRO=humble
FROM ros:${ROS_DISTRO}-ros-base

# docker/Dockerfile — dev-oriented, Humble (no GUI)
ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=${ROS_DISTRO}
ENV USERNAME=${USERNAME}
ENV USER_UID=${USER_UID}
ENV USER_GID=${USER_GID}
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create user and groups (so container files match host UID/GID when mounting)
RUN groupadd --gid "${USER_GID}" "${USERNAME}" 2>/dev/null || true \
 && useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/bash "${USERNAME}" \
 && usermod -aG plugdev,dialout "${USERNAME}" \
 && apt-get update \
 && apt-get install -y --no-install-recommends sudo \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
 && chmod 0440 /etc/sudoers.d/${USERNAME}

# Install development & ROS helper tools (keep minimal — add extras only when needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    python3-pip \
    python3-rosdep \
    python3-colcon-common-extensions \
    python3-venv \
    python-is-python3 \
    ninja-build \
    clang-format \
    ccache \
    can-utils \
    && rm -rf /var/lib/apt/lists/*

# Python pip / setuptools fixes (helps avoid ROS/Python build issues)
RUN python3 -m pip install --no-cache-dir --upgrade pip \
 && python3 -m pip install --no-cache-dir "setuptools==58.2.0" \
 && python3 -m pip install --no-cache-dir python-can matplotlib

# Copy entrypoint script (sources ROS + workspace when available)
COPY docker/ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

COPY docker/utils.sh /etc/profile.d/utils.sh
RUN chmod +x /etc/profile.d/utils.sh

# Prepare workspace and colcon log directory
USER ${USERNAME}
WORKDIR /home/${USERNAME}
RUN mkdir -p /home/${USERNAME}/clankus_ws/src /home/${USERNAME}/.colcon/log

# Helpful defaults in .bashrc
RUN { \
  echo "source /opt/ros/${ROS_DISTRO}/setup.bash"; \
  echo "if [ -f /home/${USERNAME}/clankus_ws/install/setup.bash ]; then source /home/${USERNAME}/clankus_ws/install/setup.bash; fi"; \
  } >> /home/${USERNAME}/.bashrc

RUN echo "source /etc/profile.d/utils.sh" >> /home/${USERNAME}/.bashrc


ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
