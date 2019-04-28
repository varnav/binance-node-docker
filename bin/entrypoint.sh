#!/bin/bash

source setup.sh
echo "Running $0 as $USER in $PWD"
set -ex
exec sudo -u bnbchaind "/usr/local/bin/bnbchaind start --home ${BNCHOME} --pruning breathe"
