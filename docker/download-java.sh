#!/usr/bin/env bash

FILE_NAME=jdk-8u60-linux-x64.tar.gz

[ -f $FILE_NAME ] || wget --progress=bar --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/$FILE_NAME