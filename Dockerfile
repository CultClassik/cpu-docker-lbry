FROM library/ubuntu:xenial

MAINTAINER Chris Diehl <cultclassik@gmail.com>


# This is the app I think, use this for wallet?
#ENV MINER_VER="0.19.2"
#ENV MINER_FILE="LBRY_${MINER_VER}_amd64.deb"
#ENV MINER_URL="https://github.com/lbryio/lbry-app/releases/download/v${MINER_VER}/${MINER_FILE}"

ENV MINER_VER="0.12.0.6"
ENV MINER_FILE="lbrycrd-linux.zip"
ENV MINER_URL="https://github.com/lbryio/lbrycrd/releases/download/v${MINER_VER}/lbrycrd-linux.zip"

ENV RPC_PORT=9245

ENV WORKER="myminer"
ENV MYCRYPTO="0x96ae82e89ff22b3eff481e2499948c562354cb23"
ENV POOL_SERVER="update_this_field"
ENV POOL_PORT=""
ENV POOL_USER="nobody"
ENV POOL_PASS="x"
ENV INTENSITY=64
ENV TEMP_UNITS="C"
ENV API="0.0.0.0:42000"

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip &&\
    rm -rf /var/lib/apt/lists/*

RUN mkdir /miner

WORKDIR /miner

RUN wget --no-check-certificate $MINER_URL &&\
    unzip $MINER_FILE &&\
    rm $MINER_FILE

RUN apt-get remove -y \
    wget \
    unzip &&\
    apt autoremove -y &&\
    rm -rf /var/lib/apt/lists/*


#VOLUME ~/.lbry

EXPOSE 9245/tcp

CMD [ "/miner/lbrycrdd", "-server", "-printtoconsole", "-gen", "-rpcport", "${RPC_PORT}" ]