# Docker Installation

<!-- ----------------------------------------------------------------------- -->
<!-- Download -->
<!-- ----------------------------------------------------------------------- -->
## Download
### Windows or Mac
_Download_ <br>
Download Docker Desktop (need Windows 10 Pro, not Home, because of Hyper-V)
- Windows - https://docs.docker.com/docker-for-windows/install/
- Mac - https://docs.docker.com/docker-for-mac/install/

### Ubuntu
_Download_ <br>
Follow instructions: https://docs.docker.com/install/linux/docker-ce/ubuntu/ (quite long)

_Run Rootless_ <br>
Running docker without sudo: https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo. Check docker version: `docker -v` > 19.03. These instructions also show how to do it:
https://github.com/sindresorhus/guides/blob/master/docker-without-sudo.md

```bash
# add docker to group (may already be done)
sudo groupadd docker

# add user to docker group
sudo gpasswd -a $USER docker

# login/out or restart group
newgrp docker # rather, just restart computer and don't do this

# test without sudo
docker run hello-world
```

<!-- ----------------------------------------------------------------------- -->
<!-- Running Docker -->
<!-- ----------------------------------------------------------------------- -->
## Setting up Docker

### Docker CLI
__Disk Management__
- `docker system df [OPTIONS]`
- `docker system prune` = remove any lingering containers, or other resources
  - `-a, --all`
  - `-f, --force`
  - `--volumes`
- `docker ps`
  - `-a` = all information
  - `-s` = size information

__Images/Container__
- `docker search` - search for docker image in repo
- `docker pull` - pull the image from repo
- `docker container` [`ls`, `rm`]
- `docker image` [`ls`, `s`]

__Running__
- `docker build` - build the image
- `docker run <image> <command>` - create container after image, command is typically `/bin/bash` or a shell command
  - `-i` = in interactive mode
  - `-t` = using tty shell
  - `-p` = define port
  - `-d` = detach (daemon) mode
  - `--rm` = remove container after use
  - `--name` = give name to container, this will show up in `docker ps`, and can be addressed on the command prompt. Otherwise, a random name is give by docker.

### Dockerfile
- `FROM`
- `LABEL`
- `WORKDIR`
- `ENV` - escaped using `$<VAR>`
- `RUN`
- `CMD`

<!-- ----------------------------------------------------------------------- -->
<!-- Python/Conda Specific -->
<!-- ----------------------------------------------------------------------- -->
## Python/Conda Images
Anaconda Docker Hub: https://hub.docker.com/_/anaconda

### Miniconda Image
```bash
# Display a list of available images
docker search continuumio

# Pull the desired image
docker pull continuumio/miniconda

# Create a container using the image:
docker run -t -i continuumio/miniconda /bin/bash
```

### Creating/Accessing image
https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d257544

https://runnable.com/docker/python/dockerize-your-python-application

https://www.analyticsvidhya.com/blog/2017/11/reproducible-data-science-docker-for-data-science/

### Hooking in Spyder IDE
