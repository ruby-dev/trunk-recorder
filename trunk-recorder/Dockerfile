FROM robotastic/trunk-recorder:latest

##
## GENERAL CONFIGURATION
##

##
## WORK DIRECTORY CONFIGURATION
##

COPY ./app/entrypoint.sh /entrypoint.sh

##
## COMMON CONFIGURATION
##

##
## CONFIGURE 
##

##
## STARTUP CONFIGURATION
##
ENTRYPOINT ["/entrypoint.sh"]
CMD ["trunk-recorder", "--config=/app/config.json"]
