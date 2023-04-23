#!/bin/bash

echo "install..."

apt install make

# install go
GO_VERSION=1.19.5
curl -LO https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
grep /usr/local/go/bin $HOME/.profile || echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile
export GOPATH=/go
export PATH=$PATH:/usr/local/go/bin
go version


# build lnd
LND_VER="v0.13.0-beta"

mkdir -p ${GOPATH}
cd ${GOPATH}
git clone https://github.com/lightningnetwork/lnd.git
cd ${GOPATH}/lnd
git checkout tags/${LND_VER}
make clean && make && make install

mv lnd /lnd

# mv cli & permission
mv lcli /usr/local/bin
chmod +x /usr/local/bin/lcli
