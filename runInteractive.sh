#!/usr/bin/env bash
echo "Building php..."
docker build -t php-dev-lambda amazonlinux
docker run  -i -t -v $PWD:/packaging php-dev-lambda /bin/bash