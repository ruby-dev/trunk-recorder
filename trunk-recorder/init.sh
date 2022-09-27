#!/bin/bash

if [[ "$TR_GENERATE_TEMPLATE" =~ ^[T-t]rue* ]]; then
  cat /app/config-template.json | mo > /app/config/trunk-recorder.json
fi

case "$1" in
  start-service)
    trunk-recorder --config /app/config/trunk-recorder.json
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
