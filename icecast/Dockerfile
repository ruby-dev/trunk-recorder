FROM alpine:latest

##
## GENERAL CONFIGURATION
##
ARG APP="/app"

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

##
## WORK DIRECTORY CONFIGURATION
##
RUN mkdir -p $APP
WORKDIR $APP

##
## INSTALL TOOLS
##
RUN apk add --no-cache curl && curl -sSL https://git.io/get-mo -o /usr/local/bin/mo && chmod +x /usr/local/bin/mo
COPY ./init.sh /init.sh
RUN chmod +x /init.sh
VOLUME ["/app/templates","/app/recordings"]

##############################################################
## START ICECAST BUILD
##
RUN apk add --no-cache icecast bash
COPY ./templates/mime.types /etc/mime.types
##
## END ICECAST BUILD
##############################################################

##
## RUNTIME CONFIGURATION
##
EXPOSE 8000
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/init.sh"]
CMD ["start-service"]
