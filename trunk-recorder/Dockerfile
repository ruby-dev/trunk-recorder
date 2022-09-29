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
RUN apt-get update && apt-get install nano unzip -y

## ADD BOOT SCRIPTS & SERVICES
COPY ./boot /etc/my_init.d
COPY ./service /etc/service
RUN chmod +x /etc/my_init.d/* && \
    chmod +x /etc/service/*/run

## CONFIGURE DATA VOLUMES
VOLUME ["/app/templates", "/app/storage", "/app/recordings", "/app/streams"]

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

CMD ["/sbin/my_init"]
