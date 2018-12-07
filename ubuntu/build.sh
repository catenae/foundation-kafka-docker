#!/bin/bash
docker build \
--build-arg CATENAE_VERSION=$CATENAE_VERSION \
--build-arg LIBRDKAFKA_VERSION=$LIBRDKAFKA_VERSION \
--build-arg CONFLUENT_KAFKA_VERSION=$CONFLUENT_KAFKA_VERSION \
-t catenae/link:ubuntu .
docker tag catenae/link:ubuntu catenae/link:latest
docker tag catenae/link:ubuntu catenae/link:ubuntu_$CATENAE_VERSION
docker tag catenae/link:ubuntu catenae/link:$CATENAE_VERSION
