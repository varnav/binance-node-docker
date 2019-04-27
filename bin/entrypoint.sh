#!/bin/bash

source setup.sh
set -ex
exec /usr/local/bin/bnbchaind start --home ${BNCHOME} --pruning breathe
