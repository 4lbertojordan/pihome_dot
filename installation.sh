#!/bin/bash
set -e

echo "Debian full upgrade"
sudo apt-get update
sudo apt full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y


# Docker pre-installation
sudo echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" >> /boot/cmdline.txt

echo "Install software"
sudo apt-get install -y \
build-essential \
procps \
curl \
file \
git \
vim \
neofetch \
fail2ban \
zlib1g-dev \
libncurses5-dev \
libgdbm-dev \
libnss3-dev \
libssl-dev \
libreadline-dev \
libffi-dev \
speedometer

# Install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add external USB drives

sudo mkdir -p /usb0
sudo mkdir -p /usb1

echo "UUID=$DISK0 /usb0 ext4 defaults 0 0" | sudo tee -a /etc/fstab
echo "UUID=$DISK1 /usb1 ext4 defaults 0 0" | sudo tee -a /etc/fstab


