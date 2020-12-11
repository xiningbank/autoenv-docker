#!/bin/bash

apt-get update

# install docker
apt-get install docker.io -y
cat daemon.json >> /etc/docker/daemon.json
systemctl restart docker

cat .bashrc >> ~/.bashrc

# install docker-compose
apt-get install curl -y
# for other versions, see: https://github.com/docker/compose/releases
dcVersion="1.27.4"
curl -L "https://github.com/docker/compose/releases/download/"$dcVersion"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# download docker LEMP configurations
baseDir="/var/www"
mkdir -p $baseDir
cd $baseDir

git clone -b develop git@github.com:xiningbank/dockerlemp.git
cd $baseDir"/dockerlemp"
cp .env.example .env

# docker build and run
docker-compose up -d --build
