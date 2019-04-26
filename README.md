# binance-node-docker
Docker image for Binance full node

## Building

`docker build . -t varnav/binance-node`

## Running:

```
ufw allow 27146/tcp
docker run -d --name binance -v /opt/binance-data:/root/.bnbchaind -e "BVER=0.5.8" -e "BNET=testnet" -p 27146:27146 -p 27147:27147 --restart unless-stopped --security-opt no-new-privileges varnav/binance-node
```

You can use `prod` instead of `testnet`. Run `rm -rf /opt/binance-data/` before switching.