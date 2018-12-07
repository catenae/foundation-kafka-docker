#!/bin/bash
docker build \
--build-arg CATENAE_VERSION=$CATENAE_VERSION \
--build-arg LIBRDKAFKA_VERSION=$LIBRDKAFKA_VERSION \
--build-arg CONFLUENT_KAFKA_VERSION=$CONFLUENT_KAFKA_VERSION \
-t catenae/link:alpine .
docker tag catenae/link:alpine catenae/link:alpine_$CATENAE_VERSION
