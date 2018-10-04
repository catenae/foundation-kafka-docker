#!/bin/bash
CATENAE_VERSION=$(cat CATENAE_VERSION)
docker build \
--build-arg CATENAE_VERSION=$CATENAE_VERSION \
--build-arg LIBRDKAFKA_VERSION=$(cat LIBRDKAFKA_VERSION) \
--build-arg CONFLUENT_KAFKA_VERSION=$(cat CONFLUENT_KAFKA_VERSION) \
-t catenae/link:alpine .
docker tag catenae/link:alpine catenae/link:alpine_$CATENAE_VERSION
