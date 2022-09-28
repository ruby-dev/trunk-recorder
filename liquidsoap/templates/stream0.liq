#!/usr/bin/liquidsoap

HOST="{{IC_HOSTNAME}}"
STREAMID="{{STREAM_0_ID}}"
MOUNT="{{STREAM_0_MOUNT}}"
PASSWORD="{{IC_SOURCE_PASSWORD}}"
NAME="{{STREAM_0_NAME}}"


%include "stream.liq"
