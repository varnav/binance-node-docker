# binance-node-docker
Docker image for [Binance full node](https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain)

[![Docker Stars](https://img.shields.io/docker/stars/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker)

## Building (optional)

`docker build . -t varnav/binance-node-docker`

## Running

```
ufw allow 27146/tcp
docker run -d --name binance -v /opt/binance-data:/root/.bnbchaind -e "BVER=0.5.8" -e "BNET=testnet" -p 27146:27146 -p 27147:27147 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node-docker
```

You can use `prod` instead of `testnet`. Run `rm -rf /opt/binance-data/` before switching.
