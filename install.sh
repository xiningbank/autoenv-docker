#!/bin/bash

# customized function, to judge if the current user has root privilege, if yes, ignore sudo command.
sudo() {
    if [ "$EUID" -eq 0 ]; then
        # user with root privilege: execute directly.
        "$@"
    else
        # non-root user: use sudo.
        command sudo "$@"
    fi
}

# update system
sudo apt-get update

# check if cURL is installed
if ! command -v curl > /dev/null 2>&1; then
  # install cURL
  sudo apt-get install curl -y
fi

# install docker on ubuntu, see: https://docs.docker.com/engine/install/ubuntu
sudo apt-get install docker.io -y

# add docker repository for China
#cat daemon.json | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker

# add alias as command for accessing docker container.
cat .bashrc >> ~/.bashrc
source ~/.bashrc

# install docker-compose
# for other versions, see: https://github.com/docker/compose/releases
# set configurations
if [ ! -f .env ]; then
  sudo cp .env.example .env
fi
. .env
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
