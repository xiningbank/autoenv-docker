#!/bin/bash

# add alias as command for accessing docker container by current user.
cat .bashrc >> ~/.bashrc
source ~/.bashrc

# update system
sudo apt-get update
apt-get install curl -y

# install docker on ubuntu, see: https://docs.docker.com/engine/install/ubuntu
apt-get install docker.io -y

# add docker repository for China
# cat daemon.json >> /etc/docker/daemon.json
systemctl restart docker

# install docker-compose
# for other versions, see: https://github.com/docker/compose/releases
# set configurations
if [! -f .env]; then
  cp .env.example .env
fi
. .env
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
