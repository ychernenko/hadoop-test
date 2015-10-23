#!/usr/bin/env bash
source ./globals.sh
docker run \
        -d \
        -p 2222:22 \
        -p 50070:50070 \
        -p 50060:50060 \
        -p 50030:50030 \
        --name=hadoop-test \
        --entrypoint=/bin/bash \
        $IMAGE_NAME \
        -c 'service sshd start; start-dfs.sh; start-yarn.sh; mr-jobhistory-daemon.sh start historyserver; tail -F logs/hadoop-$(whoami)-namenode-*.log'

