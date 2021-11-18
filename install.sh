#!/bin/bash
# load configurations
cp .env.example .env
. .env

# update system
apt update

# install docker
apt install docker.io -y
cat daemon.conf >> /etc/docker/daemon.conf
systemctl restart docker

# add alias as command for docker
cat .bashrc >> ~/.bashrc
source ~/.bashrc

# install docker-compose
# for other versions, see: https://github.com/docker/compose/releases
apt install curl -y
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# download docker LEMP
# for other git branch, see: https://github.com/xiningbank/dockerlemp
baseDir="/var/www"
mkdir -p $baseDir
cd $baseDir

git clone -b ${DOCKER_LEMP_GIT_BRANCH} git@github.com:xiningbank/dockerlemp.git
cd $baseDir"/dockerlemp"
cp .env.example .env

# docker build and run
docker-compose up -d --build
