#!/bin/bash

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 

sudo apt-get -y update
sudo apt-get -y upgrade

# # setup directories need to push to them from laptop... could automate
# sudo mkdir /opt/homeassistant/
# sudo mkdir /opt/hombridge/
# sudo mkdir /opt/postgres/

# docker stuff
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
sudo groupadd docker
sudo gpasswd -a $USER docker

system enable docker

# docker-compose stuff
#sudo curl -L https://github.com/mjuu/rpi-docker-compose/blob/master/v1.12.0/docker-compose-v1.12.0?raw=true -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

# add current user to docker group and reload
sudo usermod -a -G docker $USER
sudo exec su -l $USER

# for now install mosquitto
sudo apt-get install mosquitto

#sudo cp /opt/homeassistant/docker-compose-homeassistant.service /etc/systemd/system/
#sudo cp /opt/homebridge/docker-compose-homebridge.service /etc/systemd/system/
#sudo systemctl --system daemon-reload
#sudo systemctl enable docker-compose-homeassistant
#sudo systemctl enable docker-compose-homebridge

# usps stuff
# Due to issues with running python script in container, run python for usps locally and use imagemagick
sudo -H pip3 install paho-mqtt
sudo apt-get install imagemagick
sudo cp ./usps.service /etc/systemd/system/
sudo systemctl enable usps

# samba stuff
sudo apt-get install ntfs-3g -y
sudo apt-get install samba
sudo cp ./smb.conf /etc/samba/smb.conf
sudo systemctl restart smbd.service


# pihole because the docker image hates me - This is interactive... may run separate. Need to get additional whitelist files. 
#curl -sSL https://install.pi-hole.net | bash
#sudo mv whitelist.txt /etc/pihole/whitelist.txt

# add mount for libreelec
# (MUST DO THIS FOR IT TO WORK:) Must enable wait for network connection on boot in sudo raspi-config for this to work
#sudo mkdir /mnt/FantomHD
#sudo chown pi:pi /mnt/FantomHD
#echo '//192.168.1.108/FantomHD/ /mnt/FantomHD cifs rw,cache=strict,username=[root],password=[libreelec],domain=,uid=0,gid=0,file_mode=0755,dir_mode=0755,soft,nounix,serverino,rsize=1048576,wsize=1048576,actimeo=1' | sudo tee --append /etc/fstab
# mount it
#sudo mount -a

# add job to crontab
#write out current crontab
#crontab -l > mycron
#echo new cron into cron file
#echo "30 3 * * * /opt/ha_pi_setup/rsync_backup.sh" >> mycron
#install new cron file
#crontab mycrons
#rm mycron

# To fix potential dns issues in the container add daemon.json to /etc/docker/ 

# K3s install
sudo echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" >> /boot/cmdline.txt # may require restart
curl -sfL https://get.k3s.io | sh -

# helm install - Not tested - Refer: https://github.com/peterhuene/arm-charts
export HELM_VERSION=v2.14.1
export HELM_INSTALL_DIR=~/bin
wget https://kubernetes-helm.storage.googleapis.com/helm-$HELM_VERSION-linux-arm.tar.gz
tar xvzf helm-$HELM_VERSION-linux-arm.tar.gz
mv linux-arm/helm $HELM_INSTALL_DIR/helm
rm -rf linux-arm

helm init --tiller-image=peterhuene/tiller-arm:$HELM_VERSION

# Do homeassistant stuff for k3s helm/tiller

# Make vim pretty
sudo upgrade vim
cp ./.vimrc ~/.vimrc

# start it all
sudo systemctl start usps
#sudo systemctl start docker-compose-homebridge
#sudo systemctl start docker-compose-homeassistant