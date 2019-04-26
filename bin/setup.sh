#!/bin/sh

if [ ! -d "${BNCHOME}/config/" ]; then
mkdir -p ${BNCHOME}/config/
cp node-binary/fullnode/${BNET}/${BVER}/config/* ${BNCHOME}/config/
fi

# Turn on console logging

sed -i 's/logToConsole = false/logToConsole = true/g' ${BNCHOME}/config/app.toml