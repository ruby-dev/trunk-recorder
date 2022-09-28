#!/bin/bash

exec rm /app/icecast.xml && cat /app/templates/icecast.xml | mo > /app/icecast.xml
