#!/usr/bin/env bash

VERSION=1.6.0
FILE_NAME=apache-flume-$VERSION-bin.tar.gz
URL=http://archive.apache.org/dist/flume/$VERSION/$FILE_NAME

[ -f $FILE_NAME ] || wget --progress=bar $URL