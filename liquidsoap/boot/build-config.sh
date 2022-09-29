#!/bin/bash

file="/app/stream.liq"

if [ -f "$file" ] ; then
    rm "$file"
fi

exec cat /app/templates/stream.liq  | mo > $file


file="/app/west_houston.liq"

if [ -f "$file" ] ; then
    rm "$file"
fi

exec cat /app/templates/west_houston.liq | mo > $file
