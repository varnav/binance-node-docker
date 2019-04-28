# binance-node-docker

[![Test status](https://api.travis-ci.org/varnav/binance-node-docker.svg?branch=master)](https://travis-ci.org/varnav/binance-node-docker) [![Build status](https://img.shields.io/docker/cloud/build/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker) [![Docker Pulls](https://img.shields.io/docker/pulls/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker) [![](https://images.microbadger.com/badges/image/varnav/binance-node-docker.svg)](https://microbadger.com/images/varnav/binance-node-docker "Image details") ![Code size](https://img.shields.io/github/languages/code-size/varnav/binance-node-docker.svg) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT/)

[Binance full node docs](https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain)  
[Binance full node repo](https://github.com/binance-chain/node-binary)

Docker image for Binance Full Node  

### Features:

* Spin up full Binance node with single command. Works for testnet, prod, or both at once.
* Small image about 100MB, compared to bigger than 1 GB official repository.
* Easy updates

Don't know what all this is about? Read [newbie guide](https://github.com/varnav/binance-node-docker/blob/master/newbie-guide.md).

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
 tbnbcli version
 ```

 use `tbnbcli` for testnet and `bnbcli` for prod

### Update

`docker stop binance-testnet && docker rm binance-testnet`, pull fresh image with `docker pull varnav/binance-node-docker` and then run again, data and configs inside `/opt/binance-testnet-data` are preserved.

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
tbnbcli version
```

## Building devel branch locally

```
git clone --branch=devel https://github.com/varnav/binance-node-docker.git
cd binance-node-docker && docker build . -t varnav/binance-node-docker:devel
```