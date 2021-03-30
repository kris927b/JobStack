#!/bin/bash

DATA_DIR=$1
CONFIG_DIR=$2

set -e

for c in 1 2 3 
do
echo "== Running JobStack experiment $c by finetuning =="
# Bert Base
docker run --gpus '"'device=$CUDA_VISIBLE_DEVICES'"' --ipc=host --rm \
    --mount src=$DATA_DIR, dst=/data, type=bind \
    --mount src=$CONFIG_DIR, dst=/config, type=bind \
    python train.py --dataset_config /config/Stack/ner.json --parameters_config /config/Stack/overflow.$c.json --device 0 --name finetune.overflow.noCRF.$c.1
done