#!/bin/bash

# update system
sudo apt-get update

# check if cURL is installed
if ! command -v curl > /dev/null 2>&1; then
  # install cURL
  apt-get install curl -y
fi

# install docker on ubuntu, see: https://docs.docker.com/engine/install/ubuntu
apt-get install docker.io -y

# add docker repository for China
# cat daemon.json >> /etc/docker/daemon.json
systemctl restart docker

# add alias as command for accessing docker container.
cat .bashrc >> ~/.bashrc
source ~/.bashrc

# install docker-compose
# for other versions, see: https://github.com/docker/compose/releases
# set configurations
if [ ! -f .env ]; then
  cp .env.example .env
fi
. .env
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
