#!/usr/bin/env bash

set -e

ENV_CONFIG=~/.bashrc

yum -y install which tar openssh-server openssh-clients

echo 'root:' | chpasswd

echo 'Configuring SSH'
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sed -ri 's/UsePAM.*/UsePAM no/g' /etc/ssh/sshd_config
#sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config
echo 'Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    LogLevel QUIET
' >> ~/.ssh/config


echo 'Installing Java ...'

JAVA_DIR=/opt/java
mkdir $JAVA_DIR
tar xzf jdk-*.tar.gz -C $JAVA_DIR
JAVA_HOME=$JAVA_DIR/$(ls $JAVA_DIR)

echo "
export JAVA_HOME=$JAVA_HOME
export PATH=\$PATH:$JAVA_HOME/bin
" >> $ENV_CONFIG
source $ENV_CONFIG

echo 'Java installed'


echo 'Installing Hadoop ...'

HADOOP_DIR=/opt/hadoop
mkdir $HADOOP_DIR
tar xzf hadoop-*.tar.gz -C $HADOOP_DIR
HADOOP_HOME=$HADOOP_DIR/$(ls $HADOOP_DIR)

echo "
export HADOOP_HOME=$HADOOP_HOME
export PATH=\$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true
" >> $ENV_CONFIG
source $ENV_CONFIG

echo 'Hadoop installed'

echo 'Copying configs'
cp -rfv etc $HADOOP_HOME

hdfs namenode -format

echo 'Done'