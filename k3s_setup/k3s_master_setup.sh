#!/bin/bash

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 

sudo apt-get -y update
sudo apt-get -y upgrade

sudo echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" >> /boot/cmdline.txt

curl -sfL https://get.k3s.io | sh -

# ssl for registry
openssl req -newkey rsa:2048 -nodes -keyout registry-key.pem -x509 -days 365 -out registry.pem
kubectl -n kube-system create secret tls registry-ingress-tls --cert=registry.pem --key=registry-key.pem

# add install for registry here

# get cert from registry https
openssl s_client -connect registry-192.168.1.38:443 -showcerts > registry-ingress.crt

sudo mkdir -p /usr/local/share/ca-certificates/myregistry
sudo cp registry-ingress.crt /usr/local/share/ca-certificates/myregistry/registry-ingress.crt
sudo update-ca-certificates
cp ./registries.yaml /etc/rancher/registries.yaml

#### optional ####

# kubeconfig for pi user
mkdir ~/.kube
sudo cp /etc/rancher/k3s.yaml ~/.kube/config