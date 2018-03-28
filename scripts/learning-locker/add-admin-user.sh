#!/bin/bash -e

# setup the admin user in the database

if [[ $# -eq 0 ]]; then
  echo "Please supply the following vars:"
  echo "learning locker admin user"
  echo "learning locker admin password"
  echo "learning locker api key"
  echo "learning locker api secret"
  echo "mongodb path"
  echo "docker tag for lpg-learning-locker"
  exit 1
fi

if [[ $# -ge 6 ]]; then
  echo "Too many arguments, exiting"
  exit 1
fi

if [[ $# -le 6 ]]; then
  echo "Too few arguments, exiting"
  exit 1
fi

docker run -it -w /opt/learning-locker -e LEARNING_LOCKER_ADMIN_USER=$1 \
   -e LEARNING_LOCKER_ADMIN_PASSWORD=$2 -e LEARNING_LOCKER_API_KEY=$3 \
   -e LEARNING_LOCKER_API_SECRET=$4 -e MONGODB_PATH=$5 -e TESTING='1' \
   cshr/lpg-learning-locker:$6 /opt/learning-locker/./node_modules/.bin/babel-node /opt/learning-locker/mkadmin.js