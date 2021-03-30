#!/bin/bash

DATA_DIR=$2
CONFIG_DIR=$3
LOGS_DIR=$4
MTL_SET=$1

set -e

if [ ! -d $LOGS_DIR ]; then
    mkdir -p $LOGS_DIR
fi

for c in 1 2 3
do
echo "== Running JobStack experiment $c with MaChAmp MTL using $MTL_SET and BERTOverflow =="
# Bert Base
docker run --gpus '"'device=$CUDA_VISIBLE_DEVICES'"' --ipc=host --rm \
    --mount src=$DATA_DIR,dst=/data,type=bind \
    --mount src=$CONFIG_DIR,dst=/config,type=bind \
    --mount src=$LOGS_DIR,dst=/logs,type=bind \
    -w /machamp kris927b/jobstack:latest \
    bash -c "python train.py --dataset_config configs/Stack/MTL.$MTL_SET.json --parameters_config configs/Stack/overflow.$c.json --device 0 --name MTL.$MTL_SET.overflow.$c"

done