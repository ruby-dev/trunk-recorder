#!/bin/bash

exec cat /app/templates/config.json | mo > /app/config.json
exec cp /app/templates/channels.csv /app/channels.csv
