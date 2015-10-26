#!/usr/bin/env bash
source ./globals.sh
docker run \
        -d \
        -p 2222:22 \
        -p 50090:50090 \
        -p 50075:50075 \
        -p 50070:50070 \
        --name=hadoop-test \
        $IMAGE_NAME \
        bash -i -c 'service sshd start && start-dfs.sh && start-yarn.sh && mr-jobhistory-daemon.sh start historyserver && tail -F $HADOOP_HOME/logs/hadoop-$(whoami)-namenode-$(hostname).log'

