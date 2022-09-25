#!/bin/sh

env
set -x

set_env() {
  if [ -n "$2" ]; then
    echo "Setting '$2' to '$1' in file '$3'"
    sed -i "s/$2/$1/g" $3
  else
    echo "Setting for '$1' is missing, skipping for file '$3'." >&2
  fi
}

set_env $BROADCASTIFY_API_KEY     BROADCASTIFY_API_KEY    /app/config.json
set_env $BROADCASTIFY_NODE_ID_1   BROADCASTIFY_NODE_ID_1  /app/config.json
set_env $BROADCASTIFY_NODE_ID_2   BROADCASTIFY_NODE_ID_2  /app/config.json

set -e
exec "$@"
