##############################################################
## CONTAINER BUILDER
##############################################################

FROM alpine:edge

##
## GENERAL CONFIGURATION
##
ARG APP="/app"

##
## WORK DIRECTORY CONFIGURATION
##
RUN mkdir -p $APP
WORKDIR $APP

##
## INSTALL TOOLS
##
COPY ./init.sh /init.sh

RUN apk add --no-cache sudo curl bash libc6-compat && \
    curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo && \
    chmod +x /init.sh

##############################################################
## START TRUNK-RECORDER BUILD
##

RUN apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
      armhf) ARCH='arm' ;; \
      aarch64) ARCH='arm64' ;; \
      x86_64) ARCH='amd64' ;; \
      x86) ARCH='386' ;; \ 
      *) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
    esac && \
    curl -L "https://github.com/chuot/rdio-scanner/releases/download/v6.5.6/rdio-scanner-linux-${ARCH}-v6.5.6.zip" > /tmp/rdio-scanner.zip && \
    unzip /tmp/rdio-scanner.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/rdio-scanner && \
    rm -fR /tmp/*

##
## END TRUNK-RECORDER BUILD
##############################################################

##
## RUNTIME CONFIGURATION
##
EXPOSE 3000
STOPSIGNAL SIGQUIT
VOLUME ["/app/storage","/app/recordings"]
ENTRYPOINT ["/init.sh"]
CMD ["start-service"]
