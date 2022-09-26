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

RUN useradd -u 1000 icecast

##############################################################
## START ICECAST BUILD
##

RUN apt-get update && \
    apt-get install icecast2 -y

##
## END ICECAST BUILD
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
CMD ["icecast2", "-c", "/app/config/icecast.xml"]
