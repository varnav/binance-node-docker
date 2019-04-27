#!/bin/bash

source setup.sh
set -ex
chmod +x node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind
chmod +x node-binary/cli/${BNET}/${BVER}/linux/bnbcli
exec node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind start --home ${BNCHOME} --pruning breathe
