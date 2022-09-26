FROM ubuntu:latest

##
## GENERAL CONFIGURATION
##
ARG APP="/app"

##
## WORK DIRECTORY CONFIGURATION
##
RUN mkdir -p $APP
WORKDIR $APP
COPY ./app/entrypoint.sh /entrypoint.sh
VOLUME ["$APP_DIRECTORY/config"]

##############################################################
## START LIQUIDSOAP BUILD
##

RUN apt-get update && \
    apt-get install liquidsoap -y

##
## END LIQUIDSOAP BUILD
##############################################################

##
## RUNTIME
##
EXPOSE 8000
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/entrypoint.sh"]

##
## CONTAINER COMMANS
##
# CMD ["icecast", "-c", "/app/icecast/config.xml"]
