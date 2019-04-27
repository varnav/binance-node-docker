# Dockerfile for running Binance node from binary packages under docker
# https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain
# MIT license

# Build stage

FROM ubuntu:18.04 as builder

ARG DEBIAN_FRONTEND=noninteractive

ENV BVER=0.5.8
ENV BNET=testnet
#ENV BNET=prod
ENV BNCHOME=/root/.bnbchaind

RUN apt-get update && apt-get install -y --no-install-recommends upx ca-certificates wget git
RUN	git clone --depth 1 https://github.com/binance-chain/node-binary.git
RUN upx /node-binary/cli/testnet/${BVER}/linux/bnbcli \
&& upx /node-binary/cli/prod/${BVER}/linux/bnbcli \
&& /node-binary/fullnode/testnet/${BVER}/linux/bnbchaind \
&& upx /node-binary/fullnode/prod/${BVER}/linux/bnbchaind


# Final stage

FROM ubuntu:18.04

COPY --from=builder /node-binary/cli/testnet/${BVER}/linux/bnbcli /node-binary/cli/testnet/${BVER}/linux/
COPY --from=builder /node-binary/cli/prod/${BVER}/linux/bnbcli /node-binary/cli/testnet/${BVER}/linux/
COPY --from=builder /node-binary/fullnode/testnet/${BVER}/linux/bnbchaind /node-binary/fullnode/testnet/${BVER}/linux/
COPY --from=builder /node-binary/fullnode/prod/${BVER}/linux/bnbchaind /node-binary/fullnode/testnet/${BVER}/linux/
COPY --from=builder /node-binary/fullnode/testnet/${BVER}/config/* /node-binary/fullnode/testnet/${BVER}/config/
COPY --from=builder /node-binary/fullnode/prod/${BVER}/config/* /node-binary/fullnode/prod/${BVER}/config/
COPY ./bin/*.sh /usr/local/bin/

VOLUME ${BNCHOME}

# RPC service listen on port 27147 and P2P service listens on port 27146 by default.
# Prometheus is enabled on port 26660 by default, and the endpoint is /metrics.

EXPOSE 27146 27147 26660

ENTRYPOINT ["entrypoint.sh"]