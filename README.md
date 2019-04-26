# binance-node-docker
Docker image for Binance Full Node
[Binance full node docs](https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain)
[Binance full node repo](https://github.com/binance-chain/node-binary)

[![Docker Stars](https://img.shields.io/docker/stars/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker)

## Building

`docker build . -t varnav/binance-node`

## Running testnet

```
ufw allow 26656/tcp
docker run -d --name binance-testnet -v /opt/binance-testnet-data:/root/.bnbchaind -e "BNET=testnet" -p 26656:26656 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node
```

## Running prod

```
ufw allow 27146/tcp
docker run -d --name binance -v /opt/binance-data:/root/.bnbchaind -e "BNET=prod" -p 27146:27146 -p 27147:27147 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node
```
