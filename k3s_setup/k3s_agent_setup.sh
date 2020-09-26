#!/bin/bash

NODE_TOKEN=K10df00a34e3273b66a93424b7f8db1e6f91b44a022bd4d1964e50b1781681cff15::server:c94d402c9ab1481a5c2564d5c0dec39a
K3S_URL=https://192.168.1.38:6443
K3S_MASTER_IP=192.168.1.38

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 

sudo apt-get -y update
sudo apt-get -y upgrade

sudo echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" | sudo tee -a /boot/cmdline.txt

curl -sfL https://get.k3s.io | K3S_URL=${K3S_URL} K3S_TOKEN=${NODE_TOKEN} sh -


# get cert from registry https
openssl s_client -connect registry-192.168.1.38:443 -showcerts > registry-ingress.crt

sudo mkdir -p /usr/local/share/ca-certificates/myregistry
sudo cp registry-ingress.crt /usr/local/share/ca-certificates/myregistry/registry-ingress.crt
sudo update-ca-certificates
cp ./registries.yaml /etc/rancher/registries.yaml

#### Optionals ####

# copy over kube config assumes config exists in pi directory on master
mkdir /home/pi/.kube/
scp pi@${K3S_MASTER_IP}:/home/pi/.kube/config ~/.kube/config
# replace localhost ip with 192.168.1.38
LOCALHOST_IP="127.0.0.1"
sed -i -r "s/$LOCALHOST_IP([^0-9])+/$K3S_MASTER_IP/g" ~/.kube/config