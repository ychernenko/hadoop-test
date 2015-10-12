#!/usr/bin/env bash

source ./globals.sh
HADOOP=hadoop-$HADOOP_VERSION
HADOOP_FILE=$HADOOP.tar.gz

cd context
[ -f $HADOOP_FILE ] || wget http://apache.ip-connect.vn.ua/hadoop/common/$HADOOP/$HADOOP_FILE