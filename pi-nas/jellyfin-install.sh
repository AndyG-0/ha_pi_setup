#!/bin/bash

sudo apt install -y apt-transport-https

wget -O - https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | sudo apt-key add -

echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/debian $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list

sudo apt update

sudo apt install jellyfin

sudo usermod -aG video jellyfin

sudo systemctl restart jellyfin
