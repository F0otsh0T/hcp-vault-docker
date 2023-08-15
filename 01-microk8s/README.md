# INFRA // MICROK8S 

Canonical MicroK8s Kubernetes Environment

## Install: MacOS

```shell
brew install --cask multipass
brew install ubuntu/microk8s/microk8s
```
```shell
microk8s install
```

## Configuration

```shell
microk8s enable helm
microk8s enable storage
microk8s enable dns
microk8s enable registry
microk8s enable dashboard
microk8s enable observability
microk8s enable ingress
```
```shell
microk8s enable metallb
```
- For IP configuration of MetalLB, find IP of your MicroK8s VM(s)
- 

## Add Nodes

###### Existing Main Control Node
```shell
microk8s add-node

From the node you wish to join to this cluster, run the following:
microk8s join 192.168.1.230:25000/92b2db237428470dc4fcfc4ebbd9dc81/2c0cb3284b05

Use the '--worker' flag to join a node as a worker not running the control plane, eg:
microk8s join 192.168.1.230:25000/92b2db237428470dc4fcfc4ebbd9dc81/2c0cb3284b05 --worker

If the node you are adding is not reachable through the default interface you can use one of the following:
microk8s join 192.168.1.230:25000/92b2db237428470dc4fcfc4ebbd9dc81/2c0cb3284b05
microk8s join 10.23.209.1:25000/92b2db237428470dc4fcfc4ebbd9dc81/2c0cb3284b05
microk8s join 172.17.0.1:25000/92b2db237428470dc4fcfc4ebbd9dc81/2c0cb3284b05
```
- Take information from above output as this will be used to join your new Worker Node to the cluster

###### New Node
```shell
multipass launch 20.04 --name second-node --cpus 4 --disk 20G
multipass shell second-node

# inside second-node
microk8s join 192.168.1.230:25000/92b2db237428470dc4fcfc4ebbd9dc81/2c0cb3284b05
```

## References
###### General
- https://www.terraform.io/cli/run
- https://microk8s.io/docs/install-alternatives
- https://fabianlee.org/2021/07/25/kubernetes-microk8s-cluster-on-ubuntu-using-terraform-and-libvirt/
- https://github.com/fabianlee/microk8s-nginx-istio

###### Add Nodes
- https://thenewstack.io/add-nodes-to-your-microk8s-kubernetes-cluster/

###### Observability
- https://www.server-world.info/en/note?os=Ubuntu_20.04&p=microk8s&f=8

###### MacOS
- https://microk8s.io/docs/install-macos
- https://ubuntu.com/tutorials/install-microk8s-on-mac-os
- https://aruva.medium.com/microk8s-on-macos-2022-quick-guide-a9f86171f175
- https://discourse.ubuntu.com/t/install-microk8s-on-macos/13978

## Files

```
.
├── README.md
└── terraform
    ├── README.md
    ├── data.tf
    ├── env
    │   └── local.tfvars
    ├── main.tf
    ├── outputs.tf
    ├── variables.tf
    └── versions.tf
```


[[]]