##############################################################
## PACKAGE BUILDER CONTAINER
## BUILDS TO PACKAGE packages/packager/aarch64/[PACKAGE]
##############################################################

FROM alpine:edge AS builder

ADD build/repositories /etc/apk/repositories
RUN apk -U add sudo alpine-sdk bash

RUN mkdir -p /var/cache/distfiles && \
    adduser -D packager && \
    addgroup packager abuild && \
    chgrp abuild /var/cache/distfiles && \
    chmod g+w /var/cache/distfiles && \
    echo "packager    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD build/setup.sh /home/packager/bin/setup.sh
RUN chmod +x /home/packager/bin/setup.sh

WORKDIR /work
USER packager

ADD build /home/packager/

RUN mkdir -p /home/packager/.abuild && \
    /home/packager/bin/setup.sh && \
    sudo chown -R packager /home/packager/ && \
    sudo chgrp -R packager /home/packager/ && \
    cd /home/packager/trunk-recorder && \
    abuild checksum && \
    abuild -r

##############################################################
## CONTAINER BUILDER
##############################################################

FROM alpine:edge

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
COPY ./init.sh /init.sh

RUN apk add -U --no-cache sudo curl bash libc6-compat && \
    curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo && \
    chmod +x /init.sh

##############################################################
## START TRUNK-RECORDER BUILD
##

RUN mkdir -p ./packages
COPY --from=builder /home/packager/packages/packager/ ./packages/
ADD build/repositories /etc/apk/repositories

RUN apk add --no-cache  fdkaac sox ffmpeg

RUN APKARCH="$(apk --print-arch)" && \
    apk add -U --no-cache  --allow-untrusted ./packages/$APKARCH/trunk-recorder-*.apk && \
    rm -fR ./packages

##
## END TRUNK-RECORDER BUILD
##############################################################

##
## RUNTIME CONFIGURATION
##
EXPOSE 8000
STOPSIGNAL SIGQUIT
VOLUME ["/app/config","/app/templates","/app/storage"]
ENTRYPOINT ["/init.sh"]
CMD ["start-service"]
