#!/bin/bash
source ../env.sh
docker push catenae/link:alpine
docker push catenae/link:alpine_$CATENAE_VERSION
