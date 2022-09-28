#!/bin/bash

exec /sbin/setuser 1000 cat /app/templates/icecast.xml | mo > /app/icecast.xml
