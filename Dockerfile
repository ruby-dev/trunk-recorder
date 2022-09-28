##############################################################
## BASE IMAGE
##############################################################
##
## FROM BASE IMAGE
##
FROM phusion/baseimage:jammy-1.0.1 AS base-image

## GENERAL CONFIGURATION
ARG SERVICE_DIR="/app" \
    SERVICE_USER="app" \
    ARCH="amd64"

## CREATE APP (NON-ROOT) USER
RUN groupadd --gid 1000 --system $SERVICE_USER && \
    useradd --gid 1000 --uid 1000 --system $SERVICE_USER

## WORK DIRECTORY CONFIGURATION
RUN mkdir -p $SERVICE_DIR && chown 1000:1000 $SERVICE_DIR
WORKDIR $SERVICE_DIR

## INSTALL COMMON TOOLS
RUN curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo
RUN apt-get update && apt-get install unzip -y

## ADD BOOT SCRIPTS & SERVICES
COPY ./boot /etc/my_init.d
COPY ./service /etc/service
RUN chmod +x /etc/my_init.d/* && \
    chmod +x /etc/service/*/run

## CONFIGURE DATA VOLUMES
VOLUME ["/app/templates", "/app/storage", "/app/recordings"]

## RUN THE INIT PROCESS
CMD ["/sbin/my_init"]

##############################################################
## TRUNK RECORDER
##############################################################
##
## FROM BASE IMAGE
##

FROM base-image AS trunk-recorder

RUN apt-get install -y apt-transport-https build-essential ca-certificates \
    fdkaac git gnupg gnuradio gnuradio-dev gr-osmosdr libuhd4.1.0 libuhd-dev libboost-all-dev \
    libcurl4-openssl-dev libgmp-dev libhackrf-dev liborc-0.4-dev libpthread-stubs0-dev libssl-dev \
    libuhd-dev libusb-dev pkg-config software-properties-common cmake libsndfile1-dev sox

RUN mkdir /tmp/trunk-build && \
    git clone https://github.com/robotastic/trunk-recorder.git /tmp/trunk-recorder && \
    cd /tmp/trunk-build && \
    cmake ../trunk-recorder && \
    make && \
    make install

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##############################################################
## RADIO
##############################################################
##
## FROM BASE IMAGE
##

FROM base-image AS radio

RUN curl -L "https://github.com/chuot/rdio-scanner/releases/download/v6.5.6/rdio-scanner-linux-$ARCH-v6.5.6.zip" > /tmp/rdio-scanner.zip && \
    unzip /tmp/rdio-scanner.zip -d /app && \
    chmod +x /app/rdio-scanner

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

##############################################################
## ICECAST
##############################################################
##
## FROM BASE IMAGE
##

FROM base-image AS icecast

ENV IC_ADMIN="icemaster@localhost" \
    IC_ADMIN_PASSWORD="hackme" \
    IC_ADMIN_USER="admin" \
    IC_CLIENT_TIMEOUT="30" \
    IC_HEADER_TIMEOUT="15" \
    IC_HOSTNAME="localhost" \
    IC_LISTEN_BIND_ADDRESS="0.0.0.0" \
    IC_LISTEN_MOUNT="stream" \
    IC_LISTEN_PORT="8000" \
    IC_LOCATION="Earth" \
    IC_MAX_CLIENTS="100" \
    IC_MAX_SOURCES="4" \
    IC_SOURCE_PASSWORD="hackme" \
    IC_SOURCE_TIMEOUT="10" \
    IC_QUEUE_SIZE="524288" \
    IC_BURST_SIZE="65535" \
    IC_MASTER_RELAY_PASSWORD="hackme" \
    IC_RELAY_MASTER_SERVER="changeme" \
    IC_RELAY_MASTER_PORT="8000" \
    IC_RELAY_MASTER_UPDATE_INTERVAL="120" \
    IC_RELAY_MASTER_PASSWORD="hackme" \
    IC_DEBUG_LOGLEVEL="3" \
    IC_LOGSIZE="10000" \
    IC_GENERATE_TEMPLATE="False" \
    IC_ENABLE_RELAY="False"

RUN apt-get update -y && \
    apt-get install icecast2 -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8000

##############################################################
## LIQUIDSOAP
##############################################################
##
## FROM BASE IMAGE
##

FROM base-image AS liquidsoap

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
