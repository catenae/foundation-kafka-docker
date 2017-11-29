#!/bin/bash

docker build -t catenae/link:0.2.1 .
docker build -t catenae/link .

docker push catenae/link:0.2.1
docker push catenae/link
