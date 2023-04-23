#!/bin/bash

echo "Starting init.sh..."

BITCOIND_VERSION=0.21.0
apt-get update --qq
apt-get install -y curl unzip jq
cd /tmp
curl -# -sLO https://bitcoincore.org/bin/bitcoin-core-${BITCOIND_VERSION}/bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz
tar -zxf bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz


# move to /usr/*
cd bitcoin-${BITCOIND_VERSION}
install -vD bin/* /usr/bin
install -vD lib/* /usr/lib
cd /tmp
rm bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz
rm -rf bitcoin-${BITCOIND_VERSION}


# mv conf
mv bitcoind /bigcoind


# mv cli & permission
mv bli /usr/local/bin
chmod +x /usr/local/bin/bcli