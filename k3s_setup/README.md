# k3s_setup for HA

## Postgres Setup

1. Install postgres using apt.
1. Setup pg_hba.conf: Add `host    all             all     0.0.0.0/0       md5`
1. Setup postgresql.conf: Add `listen_addresses = '*'`
1. Create new user for postgres. See: [https://pimylifeup.com/raspberry-pi-postgresql/](https://pimylifeup.com/raspberry-pi-postgresql/)

## main node setup with postgres (Use least powerful machines for control plane/master servers)

Reference: [https://rancher.com/docs/k3s/latest/en/installation/ha/#1-create-an-external-datastore](https://rancher.com/docs/k3s/latest/en/installation/ha/#1-create-an-external-datastore])

1. First Node: `curl -sfL https://get.k3s.io | K3S_DATASTORE_ENDPOINT='postgres://k3s:${PASSWORD}@${POSTGRES_HOST}:5432/kubernetes' sh -`
1. Additional Main Nodes: 

```
curl -sfL https://get.k3s.io | sh -s - server \
  --token=${NODE_TOKEN} \
  --datastore-endpoint="postgres://k3s:${PASSWORD}@${POSTGRES_HOST}:5432/kubernetes"
```

NODE_TOKEN can be found at `/var/lib/rancher/k3s/server/node-token`

## Add Taints to main nodes to not have work scheduled

`k taint node k3s-main-1 CriticalAddonsOnly=true:NoExecute`

## Setup nginx Loadbalancer

See: `https://serversforhackers.com/c/tcp-load-balancing-with-nginx-ssl-pass-thru`

## Adding worker/agent nodes

`curl -sfL https://get.k3s.io | K3S_URL=https://${MAIN_NODES_LB}:8443 K3S_TOKEN=${NODE_TOKEN} sh`

## Add worker node labels

`k label node k3s-worker-2 node-role.kubernetes.io/worker=worker`

Reference: [https://github.com/k3s-io/k3s/issues/1289](https://github.com/k3s-io/k3s/issues/1289)

## Labeling Nodes for Loadbalancer

Example: `k label node k3s-worker-2 svccontroller.k3s.cattle.io/enablelb=true`

Documentation: [https://rancher.com/docs/k3s/latest/en/networking/](https://rancher.com/docs/k3s/latest/en/networking/)

## Adding insecure registry

Create file:  `/etc/docker/daemon.json` on each worker node. (Might be all?)

```
{
  "insecure-registries" : ["registry-192.168.1.38.nip.io"]
}
```
## setting up iptables
`sudo apt install iptables -y && sudo iptables -F && sudo update-alternatives --set iptables /usr/sbin/iptables-legacy && sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy && sudo reboot` 

Ref: [https://rancher.com/docs/k3s/latest/en/advanced/#additional-preparation-for-red-hat-centos-enterprise-linux](https://rancher.com/docs/k3s/latest/en/advanced/#additional-preparation-for-red-hat-centos-enterprise-linux)





