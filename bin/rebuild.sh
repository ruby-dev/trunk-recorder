#!/bin/bash

echo "Re-Building Trunk Recorder Stack"
read -p "This will remove all previous settings & recordings & reset (purge) your Docker System. Are you sure? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Removing Files"
  sudo rm -fR ~/trunk-recorder

  echo "Resetting Docker"
  sudo docker system prune -a

  echo "Cloning Repository"
  git clone https://github.com/ruby-dev/trunk-recorder.git

  echo "Creating Networks"
  sudo docker network create app-external

  echo "Building Containers"
  sudo docker-compose build
else
  echo "Rebuild Cancelled"
fi
