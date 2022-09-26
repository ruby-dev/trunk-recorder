FROM alpine:latest

##
## GENERAL CONFIGURATION
##
ARG APP="/app" \
    TARGETARCH \
    TARGETPLATFORM

##
## WORK DIRECTORY CONFIGURATION
##
RUN mkdir -p $APP
WORKDIR $APP

##
## INSTALL TOOLS
##
RUN apk add --no-cache curl bash && curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo

##############################################################
## START RDIO BUILD
##

RUN curl -L "https://github.com/chuot/rdio-scanner/releases/download/v6.5.6/rdio-scanner-linux-$TARGETARCH-v6.5.6.zip" > /tmp/rdio-scanner.zip && \
    unzip /tmp/rdio-scanner.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/rdio-scanner && \
    rm -fR /tmp/*

COPY ./app/init.sh /init.sh
RUN chmod +x /init.sh
RUN mkdir -p /app/storage
VOLUME ["/app/storage"]

##
## END RDIO BUILD
##############################################################

##
## RUNTIME CONFIGURATION
##
EXPOSE 3000
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/init.sh"]
CMD ["start-service"]
