#!/bin/bash

source setup.sh
echo "Running $0 as $LOGNAME in $PWD"
set -ex
su - bnbchaind -c "/usr/local/bin/bnbchaind start --home ${BNCHOME} --pruning breathe"
