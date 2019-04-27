# Dockerfile for running Binance node from binary packages under docker
# https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain
# MIT license

FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

ENV BVER=0.5.8
ENV BNET=testnet
#ENV BNET=prod
ENV BNCHOME=/root/.bnbchaind

RUN set -ex \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget git \
	&& git clone --depth 1 https://github.com/binance-chain/node-binary.git \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get purge -y --auto-remove ca-certificates wget git \
	&& rm -rf node-binary/.git

COPY ./bin /usr/local/bin

VOLUME ${BNCHOME}

# RPC service listen on port 27147 and P2P service listens on port 27146 by default.
# Prometheus is enabled on port 26660 by default, and the endpoint is /metrics.

EXPOSE 27146 27147 26660

ENTRYPOINT ["entrypoint.sh"]