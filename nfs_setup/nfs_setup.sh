#!/bin/bash

# run smb_setup first to mount the drive
sudo apt-get install nfs-kernel-server

sudo cp exports /etc/exports

sudo systemctl restart nfs-kernel-server
