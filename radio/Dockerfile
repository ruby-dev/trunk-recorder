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
## RADIO
##############################################################
##
## FROM BASE IMAGE
##

FROM base-image AS radio

ARG ARCH="amd64"

RUN curl -L "https://github.com/chuot/rdio-scanner/releases/download/v6.5.6/rdio-scanner-linux-${ARCH}-v6.5.6.zip" > /tmp/rdio-scanner.zip && \
    unzip /tmp/rdio-scanner.zip -d /app && \
    chmod +x /app/rdio-scanner

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

## RUN THE INIT PROCESS
CMD ["/sbin/my_init"]
