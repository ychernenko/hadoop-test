#!/usr/bin/env bash
source ${project.basedir}/../docker/globals.sh
docker run \
        -d \
        -p 2222:22 \
        -h haddop-test \
        --name=hadoop-test \
        -v $(pwd)/volume:/volume \
        $IMAGE_NAME \
        bash -i -c 'start-hadoop-services.sh &&
                    { flume-ng agent -n test -f /volume/test-flume-conf.properties & } &&
                    hadoop jar /volume/${project.build.finalName}.jar ychernenko.hadoop.test.WordCount /input/FlumeData* /output &&
                    hadoop fs -cat /output/*'

docker logs -f hadoop-test