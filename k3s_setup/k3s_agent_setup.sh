#!/bin/bash

NODE_TOKEN=K10df00a34e3273b66a93424b7f8db1e6f91b44a022bd4d1964e50b1781681cff15::server:c94d402c9ab1481a5c2564d5c0dec39a
K3S_URL=https://192.168.1.38:6443
K3S_MASTER_IP=192.168.1.38

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 
# Need to run pre_k3s_setup.sh and reboot before running.

sudo apt-get -y update
sudo apt-get -y upgrade

curl -sfL https://get.k3s.io | K3S_URL=${K3S_URL} K3S_TOKEN=${NODE_TOKEN} sh -

sudo mkdir -p /etc/rancher/k3s/
sudo cp ./registries.yaml /etc/rancher/k3s/registries.yaml

# restart k3s
sudo systemctl restart k3s-agent

#### Optionals ####

# copy over kube config assumes config exists in pi directory on master
mkdir /home/pi/.kube/
scp pi@${K3S_MASTER_IP}:/home/pi/.kube/config ~/.kube/config
# replace localhost ip with 192.168.1.38
LOCALHOST_IP="127.0.0.1"
sed -i -r "s/$LOCALHOST_IP([^0-9])+/$K3S_MASTER_IP/g" ~/.kube/config
