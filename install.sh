#!/bin/bash
# load configrations
cp .env.example .env

# update system
apt-get update

# install docker
apt-get install docker.io -y
cat daemon.json >> /etc/docker/daemon.json
systemctl restart docker

# add alias as command for docker
cat .bashrc >> ~/.bashrc
source ~/.bashrc

# install docker-compose
# for other versions, see: https://github.com/docker/compose/releases
apt-get install curl -y
curl -L "https://github.com/docker/compose/releases/download/"${DOCKER_COMPOSE_VERSION}"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# download docker LEMP
# for other git branch, see: https://github.com/xiningbank/dockerlemp
baseDir="/var/www"
mkdir -p $baseDir
cd $baseDir

git clone -b ${DOCKER_LEMP_GIT_BRANCH} https://github.com/xiningbank/dockerlemp.git
cd $baseDir"/dockerlemp"
cp .env.example .env

# docker build and run
docker-compose up -d --build
