#!/usr/bin/env bash
source ./globals.sh
docker run \
        -d \
        -p 2222:22 \
        -p 50090:50090 \
        -p 50075:50075 \
        -p 50070:50070 \
        -h haddop-test \
        --name=hadoop-test \
        $IMAGE_NAME \
        bash -i -c 'start-hadoop-services.sh && tail -F $HADOOP_HOME/logs/hadoop-$(whoami)-namenode-$(hostname).log'

