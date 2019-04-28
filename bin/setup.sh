#!/bin/sh

if [ ! -d "${BNCHOME}/config/" ]; then
mkdir -p ${BNCHOME}/config/
cp /node-binary/fullnode/${BNET}/${BVER}/config/* ${BNCHOME}/config/
fi

cp /node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind /usr/local/bin/
cp /node-binary/cli/${BNET}/${BVER}/linux/bnbcli /usr/local/bin/
cp /node-binary/cli/${BNET}/${BVER}/linux/tbnbcli /usr/local/bin/

chmod +x /usr/local/bin/bnbchaind
chmod +x /usr/local/bin/bnbcli
chmod +x /usr/local/bin/tbnbcli

# Turn on console logging

sed -i 's/logToConsole = false/logToConsole = true/g' ${BNCHOME}/config/app.toml