#!/usr/bin/env bash

HADOOP_VERSION=2.7.1
HADOOP_FILE=hadoop-$HADOOP_VERSION.tar.gz

[ -f $HADOOP_FILE ] || wget --progress=bar http://apache.ip-connect.vn.ua/hadoop/common/hadoop-$HADOOP_VERSION/$HADOOP_FILE