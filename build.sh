#!/bin/sh
set -e

# Is docker available?
if ! type docker >/dev/null; then
  echo "Please install docker"
  exit 1
fi

echo "Building php..."
docker build -t php-dev-lambda amazonlinux
docker run -it -v $PWD:/packaging amazonlinux /bin/bash
