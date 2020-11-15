#!/bin/bash

# add mount for libreelec
# (MUST DO THIS FOR IT TO WORK:) Must enable wait for network connection on boot in sudo raspi-config for this to work
sudo mkdir /mnt/FantomHD
sudo chown pi:pi /mnt/FantomHD
echo '//192.168.1.108/FantomHD/ /mnt/FantomHD cifs rw,cache=strict,username=[root],password=[libreelec],domain=,uid=0,gid=0,file_mode=0755,dir_mode=0755,soft,nounix,serverino,rsize=1048576,wsize=1048576,actimeo=1' | sudo tee --append /etc/fstab
# mount it
sudo mount -a

# Copy scripts
mkdir /opt/backup_scripts/ && cp ./rsync_backup.sh /opt/backup_scripts/rsync_backup.sh && cp ./exclude_files.txt /opt/backup_scripts/exclude_files.txt

# create crontab
# add job to crontab
# write out current crontab
crontab -l > mycron

# echo new cron into cron file
echo "30 3 * * * /opt/backup_scripts/rsync_backup.sh" >> mycron

# install new cron file
crontab mycron
rm mycron
