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

## CONFIGURE APPLICATIONS
RUN apt-get update -y

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
VOLUME ["/app/templates", "/app/storage"]

## RUN THE INIT PROCESS
EXPOSE 8000
CMD ["/sbin/my_init"]
