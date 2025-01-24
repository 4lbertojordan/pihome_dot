#!/bin/bash
set -e

echo "Debian full upgrade"
sudo apt-get update
sudo apt full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# KDE Plasma installation
sudo apt-get install -y \
kde-plasma-desktop

sudo apt install sddm -y
sudo dpkg-reconfigure sddm

sudo systemctl set-default graphical.target

sudo reboot

sudo apt install raspberrypi-ui-mods mesa-utils -y

sudo vim /boot/firmware/config.txt


# Docker pre-installation
sudo echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" >> /boot/firmware/cmdline.txt

echo "Install software"
sudo apt-get install -y \
vim \
neofetch \
fail2ban \
speedometer \
btop

# Install Docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER

# VNC server
## ADD to /etc/tigervnc/vncserver.users >> :1=albertojordan
## Set following lines in: ~/.vnc/config
geometry=1920x1080
dpi=96
localhost

sudo systemctl enable tigervncserver@:1.service

# Tunneling for VNC
ssh -i ~/workspace/ssh/pi5 -p 53122 -L 5901:127.0.0.1:5901 -N -f -l albertojordan 192.168.153.107
ssh -i ~/workspace/ssh/pi4 -p 53123 -L 5902:127.0.0.1:5901 -N -f -l albertojordan 192.168.153.124

# Add external USB drives

sudo mkdir -p /usb0
sudo mkdir -p /usb1

echo "UUID=$DISK0 /usb0 ext4 defaults 0 0" | sudo tee -a /etc/fstab
echo "UUID=$DISK1 /usb1 ext4 defaults 0 0" | sudo tee -a /etc/fstab


/dev/sdb1: LABEL="usb1" UUID="df67daaf-4391-49c9-a05f-5a8be688bc64" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="1c18c31c-01"

# Fail2Ban

sudo touch /var/log/vnc.log
sudo chmod 640 /var/log/vnc.log
sudo chown root:adm /var/log/vnc.log

sudo touch /var/log/auth.log
sudo chmod 640 /var/log/auth.log
sudo chown root:adm /var/log/auth.log

# KDE Plasma
# NO INSTALAR raspberrypi-ui-mods
