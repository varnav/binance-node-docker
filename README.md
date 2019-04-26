# binance-node-docker
[Binance full node docs](https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain)  
[Binance full node repo](https://github.com/binance-chain/node-binary)

Docker image for Binance Full Node  

[![Docker Stars](https://img.shields.io/docker/stars/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/binance-node-docker.svg)](https://hub.docker.com/r/varnav/binance-node-docker)

## Building

`docker build . -t varnav/binance-node`

## Testnet

### Run

```
ufw allow 26656/tcp
docker run -d --name binance-testnet -v /opt/binance-testnet-data:/root/.bnbchaind -e "BNET=testnet" -p 26656:26656 -p 26660:26660 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node
```

### Check logs

`docker logs -f binance-testnet`

### Monitor

[Prometheus](https://prometheus.io/) is enabled on port 26660 by default, and the endpoint is /metrics.

### Update

`docker stop binance-testnet && docker rm binance-testnet` and then run again, data and configs inside `/opt/binance-testnet-data` is preserved.

## Prod

### Run

```
ufw allow 27146/tcp
docker run -d --name binance -v /opt/binance-data:/root/.bnbchaind -e "BNET=prod" -p 27146:27146 -p 27147:27147 -p 26660:26660 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node
```

Both can be run at once, use `-p 27147:27147` for publishing RPC port where you would like.

