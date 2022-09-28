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


##############################################################
## LIQUIDSOAP
##############################################################
##
## FROM BASE IMAGE
##

FROM base-image AS liquidsoap

RUN apt-get install fdkaac ffmpeg sox liquidsoap -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## RUN THE INIT PROCESS
CMD ["/sbin/my_init"]
