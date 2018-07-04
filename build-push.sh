#!/bin/bash

docker build \
--build-arg CATENAE_VERSION=$(cat CATENAE_VERSION) \
--build-arg LIBRDKAFKA_VERSION=$(cat LIBRDKAFKA_VERSION) \
-t catenae/link .
docker push catenae/link
