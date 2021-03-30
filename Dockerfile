FROM pytorch/pytorch:1.7.1-cuda11.0-cudnn8-runtime

RUN apt-get update -y

RUN apt-get install -y vim nano python3 python3-venv python3-pip

COPY ./bilstm-aux /bilty
COPY ./machamp  /machamp

WORKDIR /workspace

RUN python3 -m venv jobstack 
RUN ["/bin/bash", "-c", "source /workspace/jobstack/bin/activate"]
RUN echo $(python3 --version)
RUN pip3 install dill==0.3.1.1 dyNET==2.1.2 transformers==4.0.0
RUN pip3 install allennlp==1.3