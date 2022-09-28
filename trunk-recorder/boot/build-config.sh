#!/bin/bash

exec /sbin/setuser 1000 cat /app/templates/config.json | mo > /app/config.json
exec /sbin/setuser 1000 cp /app/templates/channels.csv /app/channels.csv
