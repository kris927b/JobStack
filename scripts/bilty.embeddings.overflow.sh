#!/bin/bash

MTL_SET=$1
DATA_DIR=$2

set -e

for sets in train dev test
do
echo "== Generating embeddings for $MTL_SET using Overflow =="
# Bert Base
docker run --ipc=host --rm \
    --mount src=$DATA_DIR,dst=/data,type=bind \
    -w /bilty kris927b/jobstack:latest \
    bash -c "python embeds/transf.py jeniya/BERTOverflow /data/$MTL_SET/$sets.conll"

done