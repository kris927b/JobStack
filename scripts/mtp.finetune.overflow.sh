#!/bin/bash

DATA_DIR=$1
CONFIG_DIR=$2

set -e

for c in 1 2 3 
do
echo "== Running JobStack experiment $c with MaChAmp by finetuning BERTOverflow =="
# Bert Overflow
docker run --gpus '"'device=$CUDA_VISIBLE_DEVICES'"' --ipc=host --rm \
    --mount src=$DATA_DIR,dst=/data,type=bind \
    --mount src=$CONFIG_DIR,dst=/config,type=bind \
    --mount src=$LOGS_DIR,dst=/logs,type=bind \
    -w /machamp kris927b/jobstack:latest \
    bash -c "python train.py --dataset_config /config/ner.json --parameters_config /config/overflow.$c.json --device 0 --name finetune.overflow.CRF.$c"
done
