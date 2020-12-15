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

# install helm for next step
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# add helm install for registry here
git clone git@github.com:AndyG-0/docker-registry.git
cd docker-registry || exit
helm install registry .

sudo mkdir -p /etc/rancher/k3s/
sudo cp ./registries.yaml /etc/rancher/k3s/registries.yaml

# restart k3s
sudo systemctl restart k3s-agent
