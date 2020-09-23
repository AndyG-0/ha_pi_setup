#!/bin/bash

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 

sudo apt-get update && sudo apt-get upgrade

# samba stuff
sudo apt-get install ntfs-3g -y
sudo apt-get install samba
sudo cp ./smb.conf /etc/samba/smb.conf
sudo systemctl restart smbd.service

# add job to crontab
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "30 3 * * * /opt/ha_pi_setup/rsync_backup.sh" >> mycron
#install new cron file
crontab mycron
rm mycron