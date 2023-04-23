FROM ubuntu:latest as os-base

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get install -yqq \
    curl unzip jq

FROM os-base as bitcoind-install

ARG BITCOIND_VER=0.21.0

RUN cd /tmp && \
	curl -# -sLO https://bitcoincore.org/bin/bitcoin-core-${BITCOIND_VER}/bitcoin-${BITCOIND_VER}-x86_64-linux-gnu.tar.gz && \
	tar -zxf bitcoin-${BITCOIND_VER}-x86_64-linux-gnu.tar.gz && \
	cd bitcoin-${BITCOIND_VER} && \
	install -vD bin/* /usr/bin && \
	install -vD lib/* /usr/lib && \
	cd /tmp && \
	rm bitcoin-${BITCOIND_VER}-x86_64-linux-gnu.tar.gz && \
	rm -rf bitcoin-${BITCOIND_VER}


# Copy bitcoind configuration directory
COPY bitcoind /bitcoind
RUN ln -s /bitcoind /root/.

# Copy support scripts
COPY init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/install.sh
COPY cli.sh /usr/local/bin
RUN chmod +x /usr/local/bin/cli

# bitcoind P2P
EXPOSE 18444/tcp
# bitcoind regtest RPC
EXPOSE 18443/tcp
# zmqpubrawblock
EXPOSE 12005/tcp
# zmqpubrawtx
EXPOSE 12006/tcp

WORKDIR /bitcoind
#ENTRYPOINT ["/usr/local/bin/install.sh"]
