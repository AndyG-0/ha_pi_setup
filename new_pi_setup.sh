#!/bin/bash

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 

# setup directories need to push to them from laptop... could automate
sudo mkdir /opt/homeassistant/
sudo mkdir /opt/hombridge/
sudo mkdir /opt/postgres/

# docker stuff
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
sudo groupadd docker
sudo gpasswd -a $USER docker

system enable docker

# docker-compose stuff
sudo curl -L https://github.com/mjuu/rpi-docker-compose/blob/master/v1.12.0/docker-compose-v1.12.0?raw=true -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

# for now install mosquitto
sudo apt-get install mosquitto

sudo cp /opt/homeassistant/docker-compose-homeassistant.service /etc/systemd/system/
sudo cp /opt/homebridge/docker-compose-homebridge.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable docker-compose-homeassistant
sudo systemctl enable docker-compose-homebridge

# usps stuff
# Due to issues with running python script in container, run python for usps locally and use imagemagick
sudo apt-get install imagemagick
sudo cp ./usps.service /etc/systemd/system/
sudo systemctl enable usps

# samba stuff
sudo apt-get install ntfs-3g -y
sudo apt-get install samba
cp ./smb.conf /etc/samba/smb.conf
#copy smb.conf from libreelec to pi. automate this!!!


# pihole because the docker image hates me - This is interactive... may run separate. Need to get additional whitelist files. 
curl -sSL https://install.pi-hole.net | bash

# add mount for libreelec
# (MUST DO THIS FOR IT TO WORK:) Must enable wait for network connection on boot in sudo raspi-config for this to work
echo -e "//192.168.1.108/FantomHD/ /mnt/FantomHD cifs rw,cache=strict,username=[root],password=[libreelec],domain=,uid=0,gid=0,file_mode=0755,dir_mode=0755,soft,nounix,serverino,rsize=1048576,wsize=1048576,actimeo=1" >> /etc/fstab

# add job to crontab
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "30 3 * * * /opt/homeassistant/backup_scripts/rsync_backup.sh" >> mycron
#install new cron file
crontab mycron
rm mycron

# To fix potential dns issues in the container add daemon.json to /etc/docker/ 

# start it all
sudo systemctl start usps
sudo systemctl start docker-compose-homebridge
sudo systemctl start docker-compose-homeassistant