# Start from the official ROS 2 Jazzy desktop image
FROM osrf/ros:jazzy-desktop

# Use bash for RUN commands (setup.bash requires bash)
SHELL ["/bin/bash", "-c"]

# Install additional tools (optional)
RUN apt-get update && apt-get install -y \
    nano \
    ros-jazzy-turtlesim \
    && rm -rf /var/lib/apt/lists/*

# Create a workspace
RUN mkdir -p /ros2_ws/src

# Source ROS 2 automatically when you enter the container
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

# Copy the workspace source code
COPY ros2_ws /ros2_ws

# Build the workspace with colcon
RUN cd /ros2_ws && \
    . /opt/ros/jazzy/setup.bash && \
    colcon build --symlink-install

# Set the working directory
WORKDIR /ros2_ws

# Default command
CMD ["bash"]