#!/bin/bash

CRF=$1
DATA_DIR=$2
MODELS_DIR=$3
LOGS_DIR=$4
PREDS_DIR=$5

declare -A seed

seed[1]=3477689
seed[2]=4213916
seed[3]=8749520

set -e

if [ ! -d $LOGS_DIR ]; then
    mkdir -p $LOGS_DIR
fi

if [ ! -d $MODELS_DIR ]; then
    mkdir -p $MODELS_DIR
fi

if [ ! -d $PREDS_DIR ]; then
    mkdir -p $PREDS_DIR
fi

for c in "${!seed[@]}"; do
    echo "== Running JobStack experiment $c with Bilty Bert using $CRF and Bert embeddings =="
    if [[ $CRF == "crf" ]]
    then
        docker run --ipc=host --rm \
        --mount src=$DATA_DIR,dst=/data,type=bind \
        --mount src=$MODELS_DIR,dst=/models,type=bind \
        --mount src=$LOGS_DIR,dst=/logs,type=bind \
        --mount src=$PREDS_DIR,dst=/predictions,type=bind \
        -w /bilty kris927b/jobstack:latest \
        bash -c "python src/structbilty.py --dynet-mem 1500 --dynet-autobatch 1 \
                    --train /data/JobStack/train.conll.bert-base-cased --test /data/JobStack/dev.conll.bert-base-cased \
                    --iters 12 --model /models/StackBilty.Bert.${seed[$c]} \
                    --embeds_in_file --embeds_in_file_dim 768 --crf --seed ${seed[$c]} \
                    --output /predictions/StackBilty.Bert.${seed[$c]}.$c.preds |& tee /logs/StackBilty.Bert.${seed[$c]}.$c.out"
    else
        docker run --ipc=host --rm \
        --mount src=$DATA_DIR,dst=/data,type=bind \
        --mount src=$MODELS_DIR,dst=/models,type=bind \
        --mount src=$LOGS_DIR,dst=/logs,type=bind \
        --mount src=$PREDS_DIR,dst=/predictions,type=bind \
        -w /bilty kris927b/jobstack:latest \
        bash -c "python src/structbilty.py --dynet-mem 1500 --dynet-autobatch 1 \
                    --train /data/JobStack/train.conll.bert-base-cased --test /data/JobStack/dev.conll.bert-base-cased \
                    --iters 12 --model /models/StackBilty.Bert.noCRF.${seed[$c]} \
                    --embeds_in_file --embeds_in_file_dim 768 --seed ${seed[$c]} \
                    --output /predictions/StackBilty.Bert.noCRF.${seed[$c]}.$c.preds |& tee /logs/StackBilty.Bert.noCRF.${seed[$c]}.$c.out"
    fi
done