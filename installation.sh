#!/bin/bash
set -x

echo "Ubuntu full upgrade"
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

sudo mkdir -p /usb0
sudo mkdir -p /usb1

sudo EOF >> /etc/fstab
UUID=ffb8c881-a16d-4727-b0bc-460ea9bc55d7 /usb0 ext4 defaults 0 0
UUID=df67daaf-4391-49c9-a05f-5a8be688bc64 /usb1 ext4 defaults 0 0
EOF

