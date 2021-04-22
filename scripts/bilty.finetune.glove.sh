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
    echo "== Running JobStack experiment $c with Bilty glove using $CRF and glove embeddings =="
    if [[ $CRF == "crf" ]]
    then
        docker run --ipc=host --rm \
        --mount src=$DATA_DIR,dst=/data,type=bind \
        --mount src=$MODELS_DIR,dst=/models,type=bind \
        --mount src=$LOGS_DIR,dst=/logs,type=bind \
        --mount src=$PREDS_DIR,dst=/predictions,type=bind \
        -w /bilty kris927b/jobstack:latest \
        bash -c "python src/structbilty.py --dynet-mem 1500 --dynet-autobatch 1 \
                    --train /data/JobStack/train.conll --test /data/JobStack/dev.conll \
                    --iters 12 --model /models/StackBilty.glove.${seed[$c]} \
                    --crf --seed ${seed[$c]} --embeds embeds/glove.6B.50d.txt --in_dim 50 \
                    --output /predictions/StackBilty.glove.${seed[$c]}.$c.preds |& tee /logs/StackBilty.glove.${seed[$c]}.$c.out"
    else
        docker run --ipc=host --rm \
        --mount src=$DATA_DIR,dst=/data,type=bind \
        --mount src=$MODELS_DIR,dst=/models,type=bind \
        --mount src=$LOGS_DIR,dst=/logs,type=bind \
        --mount src=$PREDS_DIR,dst=/predictions,type=bind \
        -w /bilty kris927b/jobstack:latest \
        bash -c "python src/structbilty.py --dynet-mem 1500 --dynet-autobatch 1 \
                    --train /data/JobStack/train.conll --test /data/JobStack/dev.conll \
                    --iters 12 --model /models/StackBilty.glove.noCRF.${seed[$c]} \
                    --seed ${seed[$c]} --embeds embeds/glove.6B.50d.txt --in_dim 50 \
                    --output /predictions/StackBilty.glove.noCRF.${seed[$c]}.$c.preds |& tee /logs/StackBilty.glove.noCRF.${seed[$c]}.$c.out"
    fi
done