#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

# Create usb mount directories
sudo mkdir /media/elements
sudo mkdir /media/mybook

sudo apt install -y ntfs-3g

# run smb_setup first to mount the drive
sudo apt-get install nfs-common nfs-kernel-server -y

# fstab for mounting usb drives
cat ./fstab | sudo tee -a /etc/fstab

# mount usb drives
sudo mount -a

# NFS Setup
sudo cp exports /etc/exports

sudo systemctl restart nfs-kernel-server

# Samba Setup
sudo apt-get install -y samba
sudo cp ./smb.conf /etc/samba/smb.conf
sudo systemctl restart smbd.service

# jellyfin install
sudo apt install -y apt-transport-https gnupg lsb-release
wget -O - https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | sudo apt-key add -
echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/debian $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
sudo apt update
sudo apt install -y jellyfin

# open media vault install need to remove desktop check
wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install 
