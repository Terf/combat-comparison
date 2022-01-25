#!/bin/bash

set -e
cd $(dirname "$0")

# build image
docker build -t combat-comparison .

# test
docker run --rm -it -v $PWD:$PWD -w $PWD combat-comparison combat.py
docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint="Rscript" combat-comparison combat.R

# do comparison
docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint="Rscript" combat-comparison compare.R
