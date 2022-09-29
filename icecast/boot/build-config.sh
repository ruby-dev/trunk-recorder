#!/bin/bash

file="/app/icecast.xml"

if [ -f "$file" ] ; then
    rm "$file"
fi

exec cat /app/templates/icecast.xml | mo > $file
