#!/bin/bash

if [[ ! "$IC_ENABLE_RELAY" =~ ^[T-t]rue* ]]; then
  unset ENABLE_RELAY;
fi

if [[ "$IC_GENERATE_TEMPLATE" =~ ^[T-t]rue* ]]; then
  cat /etc/custom.xml | mo > /etc/icecast.xml
fi

case "$1" in
  start-service)
    icecast -c /etc/icecast.xml
    ;;
  ash)
    ash
    ;;
  bash)
    bash
    ;;
  *)
    echo "Usage: start-service"
    exit 1
esac
