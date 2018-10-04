#!/bin/bash
CATENAE_VERSION=$(cat CATENAE_VERSION)
docker push catenae/link:alpine
docker push catenae/link:alpine_$CATENAE_VERSION
