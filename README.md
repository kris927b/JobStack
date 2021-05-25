# JobStack: Deidentification of Privacy-related entities in Job Postings

This is the code used to produce the results in the paper, published at NoDaLiDa 2021.

## Cloning this repo

This repo contains submodules which contains the source code for structbilty (bilstm-aux) and MaChAmp (mtp). 
To clone all three repos (this + 2 submodules) use the following command:

```bash
$ git clone --recurse-submodules https://github/kris927b/JobStack.git
```

Or use these two commands:

```bash
$ git clone https://github/kris927b/JobStack.git 
$ git submodule update --init --recursive
```

## Data set acquisition

You can get the data set produced as part of the paper by contacting us, either here on Github or by email. 


## Running the code

We are providing a docker image to run the code in a closed environment with all the right dependencies. 

To run the docker image you need the following requirements:

  - [nvidia driver](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-installation) (418+), 
  - [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (19.03+), 
  - [nvidia-container-toolkit](https://github.com/NVIDIA/nvidia-docker#quickstart).

### Structbilty

To run the experiments for Bilty...

#### Creating transformer embeddings

To run Bilty with static transformer embeddings, you have to create the specific embeddings in the data files. 
To do so run either of the follwing commands, depending on your preferred BERT model. 

```bash
MTL_SET = JobStack | conll | i2b2

# BERT Base
$ bash scripts/bilty.embeddings.bert.sh $MTL_SET $PATH_TO_DATA

# BERT Overflow
$ bash scripts/bilty.embeddings.overflow.sh $MTL_SET $PATH_TO_DATA
```

Where `$MTL_SET` is the name of the data set you want to convert, i.e. JobStack, conll or i2b2. 


#### Using only JobStack

To train and test Bilty with only JobStack you have the following two scenarios. 

##### Vanilla embeddings

To train embeddings from scratch, with or without transformer use either of these 3 commands:

```bash 
### Only JobStack ###
CRF = crf | nocrf

# No transformer embeddings
$ bash scripts/bilty.finetune.vanilla.sh $CRF $PATH_TO_DATA $PATH_TO_MODELS $PATH_TO_PREDS $PATH_TO_LOGS

# BERT Base embeddings
$ bash scripts/bilty.finetune.bert.sh $CRF $PATH_TO_DATA $PATH_TO_MODELS $PATH_TO_PREDS $PATH_TO_LOGS

# BERT Overflow embeddings
$ bash scripts/bilty.finetune.overflow.sh $CRF $PATH_TO_DATA $PATH_TO_MODELS $PATH_TO_PREDS $PATH_TO_LOGS
```

The last three paths (models, preds and logs) are where to save the output from the script.
And you can use the `CRF` parameter to run either with or without a CRF layer. 

##### Glove embeddings

To train Bilty with embeddings initialized from the pre-trained Glove embeddings, use the follwing command:

```bash
### Only JobStack ###
# Glove embeddings
$ bash scripts/bilty.finetune.glove.sh $CRF $PATH_TO_DATA $PATH_TO_MODELS $PATH_TO_PREDS $PATH_TO_LOGS
```

**NB:** While training, the embeddings will be updated as with the vanilla embeddings used above.


#### Multi Task Learning

To train and test Bilty with Multi Task Learning you can use either of the follwoing two commands, 
one for BERT<sub>Base</sub> and one for BERT<sub>Overflow</sub> embeddings.

```bash
### Multi Task Learning ###
MTL_SET = conll | i2b2 | both

# BERT Base
$ bash scripts/bilty.MTL.bert.sh $MTL_SET $PATH_TO_DATA $PATH_TO_MODELS $PATH_TO_PREDS $PATH_TO_LOGS

# BERT Overflow
$ bash scripts/bilty.MTL.overflow.sh $MTL_SET $PATH_TO_DATA $PATH_TO_MODELS $PATH_TO_PREDS $PATH_TO_LOGS
```

**NB:** Compared to when you created the embeddings files, `MTL_SET` can here be either, conll, i2b2 or both. 

### MaChAmp

To run the experiments using MaChAmp use either of the following 6 commands.

#### Using only JobStack

To train and test MaChAmp on only JobStack use one of these two commands. 
The first uses BERT<sub>Base</sub> as its transformer model. 
The second uses BERT<sub>Overflow</sub> as its transformer model. 
Both of them finetunes the transformer model during training.

```bash
### Only JobStack ###
# BERT Base
$ bash scripts/mtp.finetune.bert.sh $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 

# BERT Overflow
$ bash scripts/mtp.finetune.overflow.sh $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 
```

#### Multi Task Learning

To train and test MaChAmp using Multi Task Learning you should use either of the two following commands. 
Again one is to use BERT<sub>Base</sub> and the other BERT<sub>Overflow</sub>.
To select which of the two data sets to use along side JobStack input either "conll", "i2b2" or "both" in place of `MTL_DATA_SET`.

```bash
### Multi Task Learning ###
MTL_DATA_SET = conll | i2b2 | both
# BERT Base
$ bash scripts/mtp.MTL.bert.sh $MTL_DATA_SET $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 

# Bert Overflow
$ bash scripts/mtp.MTL.overflow.sh $MTL_DATA_SET $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 
```

#### Masked Language Model

The lask experiment is the Masked language model. To perform this experiment you will have to get the data by contacting us, this is also described in `data/README.md`.
Else, to run the experiments you should just do like below. 

```bash
### Masked Language Modeling ###
# BERT Base
$ bash scripts/mtp.mlm.bert.sh $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 

# BERT Overflow
$ bash scripts/mtp.mlm.overflow.sh $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 
```

The data folder pointed to by `$PATH_TO_DATA` needs to have the structure described in `data/README.md`. 

## Cite this work

If you are using this code or the accompanying data, please cite the paper:

```
@inproceedings{jensen-et-al-2021,
title = "De-identification of Privacy-related Entities in Job Postings",
author = "Jensen, {Kristian N{\o}rgaard} and Mike Zhang and Barbara Plank",
year = "2021",
month = mar,
day = "22",
language = "English",
booktitle = "Proceedings of the 23rd Nordic Conference on Computational Linguistics",
publisher = "Association for Computational Linguistics",
address = "United States",
note = "NoDaLiDa 2021 ; Conference date: 31-05-2021",
}
``` 
