#!/bin/bash
source env.sh
cd alpine
./build.sh
cd ../ubuntu
./build.sh
