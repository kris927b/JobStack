FROM nvidia/cuda:10.2-cudnn8-runtime-ubuntu18.04

RUN apt-get update -y

RUN apt-get install -y vim nano python3 python3-venv python3-pip

WORKDIR /workspace

RUN python3 -m venv jobstack 
RUN ["/bin/bash", "-c", "source /workspace/jobstack/bin/activate"]
RUN echo $(python3 --version)
RUN pip3 install dill==0.3.1.1 dyNET==2.1.2 allennlp==1.3 transformers==4.0.0 torch==1.7.0 networkx