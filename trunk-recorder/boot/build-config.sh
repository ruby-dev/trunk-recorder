#!/bin/bash

file="/app/config.json"

if [ -f "$file" ] ; then
    rm "$file"
fi

exec cat /app/templates/config.json | mo > $file

file="/app/channels.csv"

if [ -f "$file" ] ; then
    rm "$file"
fi

exec cat /app/templates/channels.csv | mo > $file

file="/app/encode_upload.py"

if [ -f "$file" ] ; then
    rm "$file"
fi

exec cat /app/templates/encode_upload.py | mo > $file
