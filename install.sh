#!/bin/bash

cat .bashrc >> ~/.bashrc

baseDir="/var/www"
mkdir -p $baseDir
cd $baseDir

git clone -b develop git@github.com:xiningbank/dockerlemp.git
cd $baseDir"/dockerlemp"
cp .env.example .env

apt-get update
apt-get install curl -y
# for other versions, see: https://github.com/docker/compose/releases
dcVersion="1.27.4"
curl -L "https://github.com/docker/compose/releases/download/"$dcVersion"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

apt-get update
apt-get install docker.io -y
cd $baseDir"/autoenv"
cat daemon.json >> /etc/docker/daemon.json
systemctl restart docker

cd $baseDir"/dockerlemp"
docker-compose up -d --build
