#!/bin/bash

# simple rsync backup to NAS

# echo "Mounting network FantomHD drive" > backup.log

# mount the drive vs connecting externally
#sudo mount //192.168.1.108/FantomHD/ /mnt/FantomHD -o username=[root],password=[libreelec],rw >> backup.log

# Mount is in the fstab but re-mount in case not mounted.
sudo mount --all

echo "Backing up FantomHD" >> backup.log

# copy the files to the mounted remote drive using rsync
rsync -auv --exclude-from='/opt/ha_pi_setup/exclude_files.txt' /mnt/FantomHD/ /media/pi/Elements/Fantom_backup/ > fantom_backup.log

echo "Done backing up FantomHD" >> backup.log

# when done umount
# umount /mnt/FantomHD


# home automation backup get homebridge and homeassistant for now. 
echo "Backing up homeassistant" >> backup.log
rsync -auv /opt/homeassistant /media/pi/Elements/HomeAutomation_backup/ > homeassistant_backup.log
echo "Done Backing up homeassistant" >> backup.log


echo "Backing up homebridge" >> backup.log
rsync -auv /opt/homebridge /media/pi/Elements/HomeAutomation_backup/ > homebridge_backup.log
echo "Done Backing up homebridge" >> backup.log