# binance-node-docker

[![Test status](https://api.travis-ci.org/varnav/binance-node-docker.svg?branch=master)](https://travis-ci.org/varnav/binance-node-docker) [![Docker Pulls](https://img.shields.io/docker/pulls/varnav/binance-node.svg)](https://hub.docker.com/r/varnav/binance-node) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT/)

[Binance full node docs](https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain)  
[Binance full node repo](https://github.com/binance-chain/node-binary)

Docker image for Binance Full Node  

### Features:

* Spin up full Binance node with single command.
* Small image about 100MB, compared to bigger than 6 GB official repository.
* Easy updates

Don't know what all this is about? Read [newbie guide](https://github.com/varnav/binance-node-docker/blob/master/newbie-guide.md).

### Run interactively

`docker run --rm -it --ulimit nofile=16000:16000 varnav/binance-node`

### Run as daemon

```
ufw allow 27146/tcp
docker run -d --name binance-node -p 27146:27146 -p 27147:27147 -p 26660:26660 --restart unless-stopped --security-opt no-new-privileges --ulimit nofile=16000:16000 varnav/binance-node
```

### Check logs

`docker logs -f binance-node`

### CLI access

 ```
 docker exec -it binance-node /bin/bash
 bnbcli version
 ```

### Update

`docker stop binance-node && docker rm binance-node`, pull fresh image with `docker pull varnav/binance-node` and then run again, data and configs in the volume `binance-data` are preserved.

### Run with kubernetes

```
kubectl apply -f .\kubernetes-deployment.yml
kubectl expose deployment binance-node --type LoadBalancer
```

## Notes

### Initial seed data

It will be faster to download data snapshot from [here](https://docs.binance.org/guides/node/snapshot.html) to speed up initial sync.

## Devel

## Building locally

```
git clone https://github.com/varnav/binance-node-docker.git
cd binance-node-docker && docker build . -t varnav/binance-node
```

### Run and get access to CLI

```
docker run --rm -d --name binance-node varnav/binance-node
docker exec -it binance-node /bin/bash
bnbcli version
```
