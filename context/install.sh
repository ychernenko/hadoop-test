#!/usr/bin/env bash

set -e

GLOBALS_HOME=/etc/profile.d
JAVA_ENV=$GLOBALS_HOME/java.sh
HADOOP_ENV=$GLOBALS_HOME/hadoop.sh

yum -y install passwd tar

useradd hadoop
echo hadoop | passwd hadoop --stdin


echo 'Installing Java ...'

JAVA_DIR=/opt/java
mkdir $JAVA_DIR
tar xzf jdk-*.tar.gz -C $JAVA_DIR
JAVA_HOME=$JAVA_DIR/$(ls $JAVA_DIR)

echo "
export JAVA_HOME=$JAVA_HOME
export PATH=$PATH:$JAVA_HOME/bin
" > $JAVA_ENV
source $JAVA_ENV

echo 'Java installed'


echo 'Installing Hadoop ...'

HADOOP_DIR=/opt/hadoop
mkdir $HADOOP_DIR
tar xzf hadoop-*.tar.gz -C $HADOOP_DIR
HADOOP_HOME=$HADOOP_DIR/$(ls $HADOOP_DIR)

echo "
export HADOOP_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/bin
" > $HADOOP_ENV
source $HADOOP_ENV

echo 'Hadoop installed'
