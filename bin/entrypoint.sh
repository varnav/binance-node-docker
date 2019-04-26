#!/bin/bash

setup.sh
set -ex
exec node-binary/fullnode/${BNET}/${BVER}/linux/bnbchaind start --home ${BNCHOME} --pruning breathe &
tail -f ${BNCHOME}/bnc.log