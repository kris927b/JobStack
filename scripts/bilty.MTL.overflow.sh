#!/bin/bash

MTL_SET=$1
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
    echo "== Running JobStack experiment $c with Bilty MTL using $MTL_SET and BERTOverflow =="
    if [[ $MTL_SET == "both"]]
    then
        docker run --ipc=host --rm \
        --mount src=$DATA_DIR,dst=/data,type=bind \
        --mount src=$MODELS_DIR,dst=/models,type=bind \
        --mount src=$LOGS_DIR,dst=/logs,type=bind \
        --mount src=$PREDS_DIR,dst=/predictions,type=bind \
        -w /bilty kris927b/jobstack:latest \
        bash -c "python src/structbilty.py --dynet-mem 1500 --dynet-autobatch 1 --pred_layer 1 1 1 \
                    --train /data/JobStack/train.conll.BERTOverflow /data/conll/train.conll.BERTOverflow /data/i2b2/train.conll.BERTOverflow \
                    --test /data/JobStack/dev.conll.BERTOverflow /data/conll/dev.conll.BERTOverflow /data/i2b2/dev.conll.BERTOverflow \
                    --model /models/MTLBilty.$MTL_SET.Overflow.${seed[$c]} --iters 12 \
                    --embeds_in_file --embeds_in_file_dim 768 --seed ${seed[$c]} --crf \
                    --output /predictions/MTLBilty.$MTL_SET.Overflow.${seed[$c]}.$c.preds |& tee /logs/MTLBilty.$MTL_SET.Overflow.${seed[$c]}.$c.out"
    else
        docker run --ipc=host --rm \
        --mount src=$DATA_DIR,dst=/data,type=bind \
        --mount src=$MODELS_DIR,dst=/models,type=bind \
        --mount src=$LOGS_DIR,dst=/logs,type=bind \
        --mount src=$PREDS_DIR,dst=/predictions,type=bind \
        -w /bilty kris927b/jobstack:latest \
        bash -c "python src/structbilty.py --dynet-mem 1500 --dynet-autobatch 1 --pred_layer 1 1 \
                    --train /data/JobStack/train.conll.BERTOverflow /data/$MTL_SET/train.conll.BERTOverflow \
                    --test /data/JobStack/dev.conll.BERTOverflow /data/$MTL_SET/dev.conll.BERTOverflow \
                    --model /models/MTLBilty.$MTL_SET.Overflow.${seed[$c]} --iters 12 \
                    --embeds_in_file --embeds_in_file_dim 768 --seed ${seed[$c]} --crf \
                    --output /predictions/MTLBilty.$MTL_SET.Overflow.${seed[$c]}.$c.preds |& tee /logs/MTLBilty.$MTL_SET.Overflow.${seed[$c]}.$c.out"
    fi
done
    