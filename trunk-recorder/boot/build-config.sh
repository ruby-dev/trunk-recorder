#!/bin/bash

exec rm /app/config.json && cat /app/templates/config.json | mo > /app/config.json
exec rm /app/channels.csv && cp /app/templates/channels.csv /app/channels.csv
