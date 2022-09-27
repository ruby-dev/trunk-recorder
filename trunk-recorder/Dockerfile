FROM alpine:latest

##
## GENERAL CONFIGURATION
##
ARG APP="/app"

ENV TR_GENERATE_TEMPLATE="true" \
    TR_STORAGE_DIRECTORY="/app/storage"

##
## WORK DIRECTORY CONFIGURATION
##
RUN mkdir -p $APP
WORKDIR $APP

##
## INSTALL TOOLS
##
RUN apk add --no-cache curl && curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo

##############################################################
## START TRUNK-RECORDER BUILD
##

RUN apk update && \
    apk upgrade && \
    apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
            -X http://dl-cdn.alpinelinux.org/alpine/edge/main \
            -X http://dl-cdn.alpinelinux.org/alpine/edge/community \
            build-base ca-certificates fdkaac git rtl-sdr librtlsdr \
            boost1.80 boost1.80-dev gnupg gnuradio gnuradio-dev \
            gr-osmosdr gr-osmosdr-dev openssl-dev libc6-compat curl-dev gmp-dev \
            orc-dev libpthread-stubs uhd uhd-libs uhd-dev libusb-dev \
            pkgconfig cmake libsndfile-dev sox bash

RUN mkdir trunk-build && \
    git clone https://github.com/robotastic/trunk-recorder.git && \
    cd trunk-build && \
    cmake ../trunk-recorder && \
    make && \
    make install

COPY ./init.sh /init.sh
RUN chmod +x /init.sh
VOLUME ["/app/config","/app/templates","/app/storage"]

##
## END TRUNK-RECORDER BUILD
##############################################################

##
## RUNTIME CONFIGURATION
##
EXPOSE 8000
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/init.sh"]
CMD ["start-service"]
