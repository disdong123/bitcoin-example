
FROM ubuntu:latest as os-base

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get install -yqq \
    curl unzip jq

FROM golang:1.13 as lnd-build

ENV GO_PATH=/go

ARG LND_VER="v0.13.1-beta"
ENV LND_VER=${LND_VER}
RUN mkdir -p ${GO_PATH}/src && \
    cd ${GO_PATH}/src && \
    go get -v -d github.com/lightningnetwork/lnd && \
    cd ${GO_PATH}/src/github.com/lightningnetwork/lnd && \
    git checkout tags/${LND_VER} && \
    make clean && make && make install


FROM os-base as lnd-run

# Copy only the executables
COPY --from=lnd-build /go/bin /go/bin

ADD https://raw.githubusercontent.com/lightningnetwork/lnd/master/contrib/lncli.bash-completion \
	   /usr/share/bash-completion/completions/lncli

COPY lnd /lnd
RUN ln -s /lnd /root/.lnd
COPY fund-lnd.sh /usr/local/bin
RUN chmod +x /usr/local/bin/fund-lnd.sh
COPY init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/init.sh
COPY wait-for-bitcoind.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wait-for-bitcoind.sh
COPY cli /usr/local/bin
RUN chmod +x /usr/local/bin/cli

# LND RPC
EXPOSE 10009/tcp

# LND P2P
EXPOSE 9735/tcp

WORKDIR /lnd
ENTRYPOINT ["/usr/local/bin/init.sh"]