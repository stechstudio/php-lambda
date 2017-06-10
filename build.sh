#!/bin/sh
set -e

if [ $# -lt 1 ]; then
  echo
  echo "Usage: $0 VERSION"
  echo "Build shared libraries for php and its dependencies via containers"
  echo
  echo "Please specify the php VERSION, e.g. 7.1.5, 7.0.20, 5.6.30"
  echo
  exit 1
fi
VERSION_PHP="$1"

# Is docker available?
if ! type docker >/dev/null; then
  echo "Please install docker"
  exit 1
fi

echo "Building php..."
docker build -t php-dev-lambda amazonlinux
docker run --rm -e "VERSION_PHP=${VERSION_PHP}" -v $PWD:/packaging php-dev-lambda sh -c "/packaging/build/php.sh"
