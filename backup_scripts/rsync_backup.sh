#!/bin/bash

# simple rsync backup to NAS

# mount the drive vs connecting externally
 sudo mount //192.168.1.108/FantomHD/ /mnt/FantomHD -o username=[root],password=[libreelec],rw

# copy the files to the mounted remote drive using rsync
rsync -r /mnt/FantomHD/ /media/pi/Elements/Fantom_backup/ > fantom_backup.log

# when done umount
umount /mnt/FantomHD


# home automation backup get homebridge and homeassistant for now. 
rsync -r /opt/homeassistant /media/pi/Elements/HomeAutomation_backup/ > homeassistant_backup.log
rsync -r /opt/homebridge /media/pi/Elements/HomeAutomation_backup/ > homebridge_backup.log