# Introduction

The following file will help you setup everything you need to run the project inside a Docker Container.

## Installing Docker Engine
##### Windows:

#TODO Complete this section

##### Ubuntu 22.04:

Go to the [Docker installation tutorial for Ubuntu](https://docs.docker.com/engine/install/ubuntu/) and follow the instruction to get Docker engine on your system.

Once Docker engine is installed, you can verify its installation with the following command.

```bash
docker version
```

If there is an output, congratulations, you have successfully installed Docker Engine !
## Creating workspace

Once Docker Engine is installed, you'll need to clone the GitHub repository of the project. We advise to do it inside the following workspace :

```bash
cd ~
mkdir -p ~/scorpius_ws/src
cd ~/scorpius_ws/src
```

You can then clone the [ScorpiUS repository](https://github.com/AraaRobot/ScorpiUS) into this workspace. We recommend using SourceGit (see [[Setup Git]] for more info) to do so.

## Building the docker image

Once the Git setup is done, you can head to the scorpius directory. There, you'll see all the project packages and the Dockerfiles. 

If the project has correctly been cloned, you'll be able to run the following command to build the docker image for the container of ScorpiUS

```bash
# Need to be in directory scorpius_ws/src/scorpius
docker build -f docker/Dockerfile -t scorpius:dev .
```

You may verify that the image has correctly been built with the command :

```bash
docker images
```

The output will show something similar to the following:

```bash
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
scorpius     dev       f074451153cb   18 seconds ago   1.18GB
```

This confirms that the image has been correctly built.

> [!NOTE]
> You can give any name and tag to your docker image, just replace "scorpius" (name) and "dev" (tag) in the building command. Just keep in mind that the rest of the setup will be using the default name and tag


## Running the docker container

Now that you have completed all previous steps, we can run the docker container in which the code has been developed. It'll automatically install all the project dependencies and utilities that may be needed.

You can now run the following command in a terminal

##### Ubuntu 22.04:
```bash
# For this command to work, you need to be inside the project directory
docker run -it --rm -v $(pwd):/home/ros/scorpius_ws/src/scorpius scorpius:dev
```

##### Windows :
```powershell
docker run --rm -it --name <container_name_optional> -v "C:\your\path\to\repo:/home/ros/scorpius_ws/src/scorpius" scorpius:dev
```

## Inside the Docker Container

The docker container is running a ros-humble headless image (for now). All dependencies of the project have been installed via the Dockerfile. Two helpers have been included to the build to help with development. 

###### ROS build:
The alias "b" can be used in a terminal to build current code
###### ROS clean:
The function "clean" can be used in a terminal to completely rebuild the workspace. It deletes the build/install/log and then proceeds to build it back twice.

## Running the code without Docker

#TODO Complete this section
If you want to run the code outside of the docker, you can create the ROS2 workspace with the following commands:

```bash
cd ~
mkdir -p ~/scorpius_ws/src
cd ~/scorpius_ws/src
```

> [!WARNING]
> Please take into consideration that everything has been developed inside the docker and you'll need to install missing dependencies for the project to work.
