#!/bin/sh

if [ ! -d "${BNCHOME}/config/" ]; then
mkdir -p ${BNCHOME}/config/
cp /node-binary/fullnode/${BNET}/${BVER}/config/* ${BNCHOME}/config/
chown -R bnbchaind:bnbchaind ${BNCHOME}/config/
fi

cp /node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind /usr/local/bin/
chmod +x /usr/local/bin/bnbchaind

if [ ${BNET} == "testnet" ];
then
    ln -s /node-binary/cli/${BNET}/${BVER}/linux/tbnbcli /usr/local/bin/tbnbcli
    chmod +x /usr/local/bin/tbnbcli
else
    ln -s /node-binary/cli/${BNET}/${BVER}/linux/bnbcli /usr/local/bin/bnbcli
    chmod +x /usr/local/bin/bnbcli
fi

# Turn on console logging

sed -i 's/logToConsole = false/logToConsole = true/g' ${BNCHOME}/config/app.toml