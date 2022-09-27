#!/bin/bash

if [ "$TR_GENERATE_TEMPLATE" = "True" ]; then
  exec /sbin/setuser app /usr/bin/cat /app/templates/config.json | /usr/local/bin/mo > /app/config.json
fi

exec /sbin/setuser app cp /app/templates/channels.csv /app/channels.csv
