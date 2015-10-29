#!/usr/bin/env bash

source globals.sh

cd context

../download-hadoop.sh
../download-java.sh
../download-flume.sh

docker build --force-rm=true --no-cache=true --rm=true -t $IMAGE_NAME .