#!/bin/bash
source env.sh
docker build \
--build-arg LIBRDKAFKA_VERSION=$LIBRDKAFKA_VERSION \
--build-arg CONFLUENT_KAFKA_VERSION=$CONFLUENT_KAFKA_VERSION \
--build-arg ROCKSDB_VERSION=$ROCKSDB_VERSION \
-t catenae/foundation:ubuntu .
docker tag catenae/foundation:ubuntu catenae/foundation:latest
