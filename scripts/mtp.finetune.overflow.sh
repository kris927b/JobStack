#!/bin/bash

CRF=$1
DATA_DIR=$2
CONFIG_DIR=$3
LOGS_DIR=$4


set -e

if [ ! -d $LOGS_DIR ]; then
    mkdir -p $LOGS_DIR
fi

for c in 1 2 3 
do
    echo "== Running JobStack experiment $c with MaChAmp by finetuning BERTOverflow =="
    if [[ $CRF == "crf" ]]
    then
        # Bert Base
        docker run --gpus '"'device=$CUDA_VISIBLE_DEVICES'"' --ipc=host --rm \
            --mount src=$DATA_DIR,dst=/data,type=bind \
            --mount src=$CONFIG_DIR,dst=/config,type=bind \
            --mount src=$LOGS_DIR,dst=/logs,type=bind \
            -w /machamp kris927b/jobstack:latest \
            bash -c "python train.py --dataset_config /config/ner.json --parameters_config /config/overflow.$c.json --device 0 --name finetune.overflow.CRF.$c"
    else
        # Bert Base
        docker run --gpus '"'device=$CUDA_VISIBLE_DEVICES'"' --ipc=host --rm \
            --mount src=$DATA_DIR,dst=/data,type=bind \
            --mount src=$CONFIG_DIR,dst=/config,type=bind \
            --mount src=$LOGS_DIR,dst=/logs,type=bind \
            -w /machamp kris927b/jobstack:latest \
            bash -c "python train.py --dataset_config /config/ner.noCRF.json --parameters_config /config/overflow.$c.json --device 0 --name finetune.overflow.noCRF.$c"

done
