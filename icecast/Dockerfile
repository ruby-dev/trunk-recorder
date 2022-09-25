FROM pltnk/icecast2

##
## COMMON CONFIGURATION
##

##
## CONFIGURE 
##

##
## STARTUP CONFIGURATION
##
ENTRYPOINT ["/app/entrypoint.sh"]

CMD /etc/init.d/icecast2 start && tail -F /var/log/icecast2/error.log
