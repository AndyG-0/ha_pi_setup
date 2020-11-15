#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

# run smb_setup first to mount the drive
sudo apt-get install nfs-common nfs-kernel-server -y

# fstab for mounting usb drives
sudo ./fstab >> /etc/fstab

# NFS Setup
sudo cp exports /etc/exports

sudo systemctl restart nfs-kernel-server

# Samba Setup
sudo apt-get install samba
sudo cp ./smb.conf /etc/samba/smb.conf
sudo systemctl restart smbd.service