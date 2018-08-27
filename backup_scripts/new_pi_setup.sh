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

cp ./docker-compose-app.service /etc/systemd/system/
systemctl enable docker-compose-app

# samba stuff
sudo apt-get install ntfs-3g -y
sudo apt-get install samba
cp ./smb.conf /etc/samba/smb.conf
#copy smb.conf from libreelec to pi. automate this!!!


# pihole because the docker image hates me - This is interactive... may run separate. Need to get additional whitelist files. 
curl -sSL https://install.pi-hole.net | bash

# add mount for libreelec
echo -e "//192.168.1.108/FantomHD/ /mnt/FantomHD -o username=[root],password=[libreelec],rw" >> /etc/fstab

# add job to crontab
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "00 09 * * * /opt/homeassistant/backup_scripts/rsync_backup.sh" >> mycron
#install new cron file
crontab mycron
rm mycron