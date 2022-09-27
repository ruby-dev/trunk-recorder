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

## CREATE APP (NON-ROOT) USER
RUN groupadd -r $APP_USER && useradd -r -g $APP_USER $APP_USER

## WORK DIRECTORY CONFIGURATION
RUN mkdir -p $APP && chown app $APP_USER && chgrp app $APP_USER
WORKDIR $APP

## CONFIGURE APPLICATIONS
RUN apt-get update -y && \
    apt-get install icecast2 -y

## DON'T FORGET TO CLEANUP
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
EXPOSE 8000
CMD ["/sbin/my_init"]
