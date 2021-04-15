# JobStack: Deidentification of Privacy-related entities in Job Postings

This is the code used to produce the results in the paper, published at NoDaLiDa 2021.

## Cloning this repo

This repo contains submodules which contains the source code for structbilty (bilstm-aux) and MaChAmp (mtp). 
To clone all three repos (this + 2 submodules) use the following command:

```bash
$ git clone --recurse-submodules https://github/nlpnorth/JobStack.git
```

Or use these two commands:

```bash
$ git clone https://github/nlpnorth/JobStack.git 
$ git submodule update --init --recursive
```

## Data set acquisition

You can get the data set produced as part of the paper by signing our DUA here: [NLPNorth.itu.dk](https://itu.dk)


## Running the code

We are providing a docker image to run the code in a closed environment with all the right dependencies. 

To run the docker image you need the following requirements:

  - [nvidia driver](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-installation) (418+), 
  - [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (19.03+), 
  - [nvidia-container-toolkit](https://github.com/NVIDIA/nvidia-docker#quickstart).

### Structbilty

To run the experiments for Bilty...


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
To select which of the two data sets to use along side JobStack input either "conll", "i2b2" or "both".

```bash
### Multi Task Learning ###
MTL_DATA_SET = conll | i2b2 | both
# BERT Base
$ bash scripts/mtp.MTL.bert.sh $MTL_DATA_SET $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 

# Bert Overflow
$ bash scripts/mtp.MTL.overflow.sh $MTL_DATA_SET $PATH_TO_DATA $PATH_TO_CONFIG $PATH_TO_LOGS 
```

#### Masked Language Model

The lask experiment is the Masked language model. To perform this experiment you will have to get the data from our website [NLPNorth.itu.dk](https://itu.dk), this is also described in `data/README.md`.
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
@inproceedings{jensen-et-al-2021

}
``` 
