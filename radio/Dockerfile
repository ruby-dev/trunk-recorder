##############################################################
## CONTAINER BUILDER
##############################################################

## FROM BASE IMAGE
FROM phusion/baseimage:jammy-1.0.1

## INSTALL COMMON TOOLS
RUN curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo
RUN apt-get update && apt-get install unzip -y

##############################################################
## START APPLLICATION CONFIGURATION
##

## GENERAL CONFIGURATION
ARG APP="/app" \
APP_USER="app" \
TARGETARCH="amd64"

## CREATE APP (NON-ROOT) USER
RUN groupadd -r $APP_USER && useradd -r -g $APP_USER $APP_USER

## WORK DIRECTORY CONFIGURATION
RUN mkdir -p $APP && chown app $APP_USER && chgrp app $APP_USER
WORKDIR $APP

## INSTALL APPLICATIONS
RUN curl -L "https://github.com/chuot/rdio-scanner/releases/download/v6.5.6/rdio-scanner-linux-${TARGETARCH}-v6.5.6.zip" > /tmp/rdio-scanner.zip && \
    unzip /tmp/rdio-scanner.zip -d /app && \
    chmod +x /app/rdio-scanner

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
VOLUME ["/app/storage", "/app/recordings"]

## RUN THE INIT PROCESS
EXPOSE 3000
CMD ["/sbin/my_init"]
