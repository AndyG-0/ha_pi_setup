#!/bin/bash

# Install docker to make sure it works with Jenkins
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
sudo groupadd docker
sudo gpasswd -a "$USER" docker

system enable docker

# add current user to docker group and reload
sudo usermod -a -G docker "$USER"
sudo exec su -l "$USER"

# add daemon.json
sudo cp ./daemon.json /etc/docker/daemon.json