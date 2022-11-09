#!/bin/bash

echo "Ubuntu full upgrade"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" >> /boot/cmdline.txt

echo "Install Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo "Add user to docker group"
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Install software"
sudo apt-get install -y \
build-essential \
procps \
curl \
file \
git \
vim \
bat \
neofetch \
python3-pip -y

echo "Install docker-compose"
sudo pip3 install docker-compose
