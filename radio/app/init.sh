#!/bin/bash

case "$1" in
  start-service)
    rdio-scanner -base_dir /app/storage
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
