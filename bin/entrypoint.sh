#!/bin/bash

setup.sh
set -ex
chmod +x node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind
exec node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind start --home ${BNCHOME} --pruning breathe
