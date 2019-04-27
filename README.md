# binance-node-docker

[![Test status](https://api.travis-ci.org/varnav/binance-node-docker.svg?branch=master)](https://travis-ci.org/varnav/binance-node-docker) [![Build status](https://img.shields.io/docker/cloud/build/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker) [![Docker Pulls](https://img.shields.io/docker/pulls/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker) [![Docker image size](https://shields.beevelop.com/docker/image/image-size/varnav/binance-node-docker/latest.svg)](https://links.beevelop.com/d-shields) ![Code size](https://img.shields.io/github/languages/code-size/varnav/binance-node-docker.svg) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

[Binance full node docs](https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain)  
[Binance full node repo](https://github.com/binance-chain/node-binary)

Docker image for Binance Full Node  

## Testnet

### Run interactively

`docker run --rm -it varnav/binance-node-docker`

### Run as daemon

```
ufw allow 26656/tcp
docker run -d --name binance-testnet -v /opt/binance-testnet-data:/root/.bnbchaind -e "BNET=testnet" -p 26656:26656 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node-docker
```

### Check logs

`docker logs -f binance-testnet`

### CLI access

 ```
 docker exec -it binance-devel /bin/bash
 bnbcli version
 ```

### Update

`docker stop binance-testnet && docker rm binance-testnet` and then run again, data and configs inside `/opt/binance-testnet-data` are preserved.

## Prod

### Run

```
ufw allow 27146/tcp
docker run -d --name binance -v /opt/binance-data:/root/.bnbchaind -e "BNET=prod" -p 27146:27146 -p 27147:27147 -p 26660:26660 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node-docker
```

You can run both testnet and prod at once, use `-p 27147:27147` for publishing RPC port for one of them.

## Devel

### Run and get access to CLI

```
docker run --rm -d --name binance-devel varnav/binance-node-docker:devel
docker exec -it binance-devel /bin/bash
bnbcli version
```

## Building devel branch locally

```
git clone --branch=devel https://github.com/varnav/binance-node-docker.git
cd binance-node-docker && docker build . -t varnav/binance-node-docker:devel
```