FROM ubuntu:20.04

# Dockerfile for running Binance node from binary packages under docker
# https://docs.binance.org/fullnode.html#run-full-node-to-join-binance-chain
# MIT license
LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Docker image for Binance full and light nodes"
LABEL License="MIT License"

ARG DEBIAN_FRONTEND=noninteractive

# UPDATE ME when new version is out !!!!
ARG CLI_LATEST_VERSION="0.8.0-hotfix"
ARG FULLNODE_LATEST_VERSION="0.8.0"
ARG GH_REPO_URL="https://github.com/binance-chain/node-binary/raw/master"
ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000

ENV BNCHOME=/opt/bnbchaind

COPY ./bin/*.sh /usr/local/bin/

RUN set -ex \
&& chmod +x /usr/local/bin/*.sh \
&& groupadd --gid "$HOST_USER_GID" bnbchaind \
&& useradd --uid "$HOST_USER_UID" --gid "$HOST_USER_GID" --shell /bin/bash --no-create-home bnbchaind \
&& mkdir -p ${BNCHOME}/config/ \
&& chown -R bnbchaind:bnbchaind "$BNCHOME" \
&& chown -R bnbchaind:bnbchaind ${BNCHOME}/config/ \
&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN set -ex \
&& wget -q https://github.com/binance-chain/node-binary/blob/master/cli/prod/$CLI_LATEST_VERSION/linux/bnbcli \
&& cd /usr/local/bin/ \
&& FULLNODE_VERSION_PATH="fullnode/prod/$FULLNODE_LATEST_VERSION" \
&& FULLNODE_CONFIG_URL="$GH_REPO_URL/$FULLNODE_VERSION_PATH/config" \
&& FULLNODE_BINARY_URL="$GH_REPO_URL/$FULLNODE_VERSION_PATH/linux/bnbchaind" \
&& wget -q "$FULLNODE_BINARY_URL" \
&& chmod 755 "./bnbchaind" \
&& cd ${BNCHOME}/config/ \
&& wget -q "$FULLNODE_CONFIG_URL/app.toml" \
&& wget -q "$FULLNODE_CONFIG_URL/config.toml" \
&& wget -q "$FULLNODE_CONFIG_URL/genesis.json" \
&& sed -i 's/logToConsole = false/logToConsole = true/g' ${BNCHOME}/config/app.toml

VOLUME ${BNCHOME}

# RPC service listen on port 27147 and P2P service listens on port 27146 by default.
# Prometheus is enabled on port 26660 by default, and the endpoint is /metrics.

EXPOSE 27146 27147 26660

ENTRYPOINT ["entrypoint.sh"]
