#!/usr/bin/env bash
source ${project.basedir}/../docker/globals.sh
docker run \
        -d \
        -p 2222:22 \
        -p 50090:50090 \
        -p 50075:50075 \
        -p 50070:50070 \
        -h haddop-test \
        --name=hadoop-test \
        -v $(pwd)/volume:/volume \
        $IMAGE_NAME \
        bash -i -c 'start-hadoop-test.sh && hadoop fs -put / $HADOOP_HOME/README.txt && hadoop jar /volume/${project.build.finalName}.jar ychernenko.hadoop.test.WordCount /README.txt /volume/output'

docker logs -f hadoop-test