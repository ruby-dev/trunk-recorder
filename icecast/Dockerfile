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

RUN useradd --user-group --system --create-home --no-log-init app

##############################################################
## START ICECAST BUILD
##

RUN apt-get update && \
    apt-get install icecast2 -y

##
## END ICECAST BUILD
##############################################################

USER app

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
