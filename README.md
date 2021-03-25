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

To run the experiments using MaChAmp...


## Cite this work

If you are using this code or the accompanying data, please cite the paper:

```
@inproceedings{jensen-et-al-2021

}
``` 
