##############################################################
## CONTAINER BUILDER
##############################################################

## FROM BASE IMAGE
FROM phusion/baseimage:jammy-1.0.1

## INSTALL COMMON TOOLS
RUN curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo

##############################################################
## START APPLLICATION CONFIGURATION
##

## GENERAL CONFIGURATION
ARG APP="/app" \
APP_USER="app"

## CREATE APP (NON-ROOT) USER
RUN groupadd -r $APP_USER && useradd -r -g $APP_USER $APP_USER

## WORK DIRECTORY CONFIGURATION
RUN mkdir -p $APP && chown app $APP_USER && chgrp app $APP_USER
WORKDIR $APP

## INSTALL APPLICATIONS
RUN apt-get update && apt-get install -y apt-transport-https build-essential ca-certificates \
    fdkaac git gnupg gnuradio gnuradio-dev gr-osmosdr libuhd4.1.0 libuhd-dev libboost-all-dev \
    libcurl4-openssl-dev libgmp-dev libhackrf-dev liborc-0.4-dev libpthread-stubs0-dev libssl-dev \
    libuhd-dev libusb-dev pkg-config software-properties-common cmake libsndfile1-dev sox

RUN mkdir /tmp/trunk-build && \
    git clone https://github.com/robotastic/trunk-recorder.git /tmp/trunk-recorder && \
    cd /tmp/trunk-build && \
    cmake ../trunk-recorder && \
    make && \
    make install

## DON'T FORGET TO CLEANUP
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -fR /tmp/*

##
## END APPLLICATION CONFIGURATION
##############################################################

## ADD BOOT SCRIPTS & SERVICES
COPY ./boot /etc/my_init.d
COPY ./service /etc/service
RUN chmod +x /etc/my_init.d/* && \
    chmod +x /etc/service/*/run

## CONFIGURE DATA VOLUMES
VOLUME ["/app/templates", "/app/storage", "/app/recordings"]

## RUN THE INIT PROCESS
CMD ["/sbin/my_init"]
