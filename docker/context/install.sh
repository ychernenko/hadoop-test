#!/usr/bin/env bash

set -e

GLOBALS_HOME=/etc/profile.d

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
tar -xzvf jdk-*.tar.gz -C $JAVA_DIR
JAVA_HOME=$JAVA_DIR/$(ls $JAVA_DIR)

{ source <(tee $GLOBALS_HOME/java.sh); } << EOF
export JAVA_HOME=$JAVA_HOME
export PATH=\$PATH:$JAVA_HOME/bin
EOF

echo 'Java installed'


echo 'Installing Hadoop ...'

HADOOP_DIR=/opt/hadoop
mkdir $HADOOP_DIR
tar -xzvf hadoop-*.tar.gz -C $HADOOP_DIR
HADOOP_HOME=$HADOOP_DIR/$(ls $HADOOP_DIR)

{ source <(tee $GLOBALS_HOME/hadoop.sh); } << EOF
export HADOOP_HOME=$HADOOP_HOME
export PATH=\$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
EOF

echo 'Hadoop installed'


echo 'Installing Flume ..'

FLUME_DIR=/opt/flume
mkdir $FLUME_DIR
tar -xzvf apache-flume-*.tar.gz -C $FLUME_DIR
FLUME_HOME=$FLUME_DIR/$(ls $FLUME_DIR)

{ source <(tee $GLOBALS_HOME/flume.sh); } << EOF
export FLUME_HOME=$FLUME_HOME
export PATH=\$PATH:$FLUME_HOME/bin:$FLUME_HOME/sbin
EOF

echo 'Flume installed'

echo 'Copying configs'
cp -rfv hadoop-home/* $HADOOP_HOME

hdfs namenode -format

echo 'Done'