#!/bin/bash

# Install bitcoind
source install.sh


# Start bitcoind
echo "Starting bitcoind..."
bitcoind -datadir=/bitcoind -daemon


# Wait for bitcoind startup
echo -n "Waiting for bitcoind to start"
until bitcoin-cli -datadir=/bitcoind -rpcwait getblockchaininfo  > /dev/null 2>&1
do
	echo -n "."
	sleep 1
done
echo
echo "bitcoind started"


# get current wallets
bitcoin-cli -datadir=/bitcoind listwallets

# Load private key into wallet
export address=`cat /bitcoind/keys/address.txt`
export privkey=`cat /bitcoind/keys/private-key.txt`

# 최초에는 지갑을 생성. 이후에는 생성된 지갑을 load 만 함
bitcoin-cli -datadir=/bitcoind createwallet regtest > /dev/null 2>&1 || bitcoin-cli -datadir=/bitcoind loadwallet regtest > /dev/null 2>&1

# 개인키 import
bitcoin-cli -datadir=/bitcoind importprivkey $privkey > /dev/null 2>&1 || true

echo "================================================"
echo "Imported demo private key"
echo "Bitcoin address: " ${address}
echo "Private key: " ${privkey}
echo "================================================"

# Executing CMD
exec "$@"