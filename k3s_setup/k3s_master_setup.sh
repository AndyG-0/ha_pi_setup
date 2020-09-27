#!/bin/bash

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 
# Need to run pre_k3s_setup.sh and reboot before running.

sudo apt-get -y update
sudo apt-get -y upgrade

curl -sfL https://get.k3s.io | sh -

# kubeconfig for pi user
mkdir ~/.kube
sudo cp /etc/rancher/k3s.yaml ~/.kube/config
sudo chown pi:pi ~/.kube/config

# ssl for registry
openssl req -newkey rsa:2048 -nodes -keyout registry-key.pem -x509 -days 365 -out registry.pem
kubectl -n kube-system create secret tls registry-ingress-tls --cert=registry.pem --key=registry-key.pem

# install helm for next step
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# add helm install for registry here
git clone git@github.com:AndyG-0/docker-registry.git
cd docker-registry || exit
helm install registry .

# take a nap while kube settles
sleep 60 

# get cert from registry https
openssl s_client -connect registry-192.168.1.38:443 -showcerts > registry-ingress.crt

sudo mkdir -p /usr/local/share/ca-certificates/myregistry
sudo cp registry-ingress.crt /usr/local/share/ca-certificates/myregistry/registry-ingress.crt
sudo update-ca-certificates
sudo cp ./registries.yaml /etc/rancher/registries.yaml
