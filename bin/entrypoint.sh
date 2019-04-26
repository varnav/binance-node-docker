#!/bin/bash

setup.sh
set -ex
chmod +x node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind
chmod +x node-binary/cli/${BNET}/${BVER}/linux/bnbcli
PATH=${PATH}:/node-binary/cli/${BNET}/${BVER}/linux/
export PATH
exec node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind start --home ${BNCHOME} --pruning breathe
