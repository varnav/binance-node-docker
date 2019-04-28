# Dockerfile for running Binance node from binary packages under docker
# https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain
# MIT license

ARG DEBIAN_FRONTEND=noninteractive

# Build stage

FROM ubuntu:18.04 as builder

# UPDATE ME when new version is out !!!!
ARG BVER=0.5.8

RUN apt-get update && apt-get install -y --no-install-recommends upx ca-certificates wget git
RUN	git clone --depth 1 https://github.com/binance-chain/node-binary.git
RUN upx /node-binary/cli/testnet/${BVER}/linux/tbnbcli \
&& upx /node-binary/cli/prod/${BVER}/linux/bnbcli \
&& upx /node-binary/fullnode/testnet/${BVER}/linux/bnbchaind \
&& upx /node-binary/fullnode/prod/${BVER}/linux/bnbchaind

# Final stage

FROM ubuntu:18.04

# UPDATE ME when new version is out !!!!
ENV BVER=0.5.8
ENV BNET=testnet
#ENV BNET=prod
ENV BNCHOME=/root/.bnbchaind

COPY --from=builder /node-binary/cli/testnet/${BVER}/linux/tbnbcli /node-binary/cli/testnet/${BVER}/linux/
COPY --from=builder /node-binary/cli/prod/${BVER}/linux/bnbcli /node-binary/cli/prod/${BVER}/linux/
COPY --from=builder /node-binary/fullnode/testnet/${BVER}/linux/bnbchaind /node-binary/fullnode/testnet/${BVER}/linux/
COPY --from=builder /node-binary/fullnode/prod/${BVER}/linux/bnbchaind /node-binary/fullnode/prod/${BVER}/linux/
COPY --from=builder /node-binary/fullnode/testnet/${BVER}/config/* /node-binary/fullnode/testnet/${BVER}/config/
COPY --from=builder /node-binary/fullnode/prod/${BVER}/config/* /node-binary/fullnode/prod/${BVER}/config/
COPY ./bin/*.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh \
&& mkdir -p ${BNCHOME}
&& groupadd --gid 1000 bnbchaind \
&& useradd --uid 1000 -g bnbchaind bnbchaind \
&& chown -R bnbchaind:bnbchaind /node-binary/ \
&& chown -R bnbchaind:bnbchaind ${BNCHOME}

VOLUME ${BNCHOME}

# RPC service listen on port 27147 and P2P service listens on port 27146 by default.
# Prometheus is enabled on port 26660 by default, and the endpoint is /metrics.

EXPOSE 27146 27147 26660

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f localhost:27147/status || exit 1

USER bnbchaind
ENTRYPOINT ["entrypoint.sh"]