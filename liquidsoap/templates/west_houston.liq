#!/usr/bin/liquidsoap

HOST="icecast"
STREAMID="west-houston"
MOUNT="west-houston"
PASSWORD="{{IC_SOURCE_PASSWORD}}"
NAME="West Houston Law Enforcement & Fire"

%include "stream.liq"
