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

set_env $ICECAST_HOSTNAME ICECAST_HOSTNAME /etc/icecast2/icecast.xml
set_env $ICECAST_ADMIN_PASSWORD ICECAST_ADMIN_PASSWORD /etc/icecast2/icecast.xml
set_env $ICECAST_SOURCE_PASSWORD ICECAST_SOURCE_PASSWORD /etc/icecast2/icecast.xml
set_env $ICECAST_RELAY_PASSWORD ICECAST_RELAY_PASSWORD /etc/icecast2/icecast.xml
set_env $ICECAST_ADMIN_PASSWORD ICECAST_ADMIN_PASSWORD /etc/icecast2/icecast.xml

set -e
exec "$@"
