FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir app

WORKDIR /app

RUN apt update && apt install -y wget git-all python2 python3 python3-pip && apt-get clean && apt install -y default-jre && apt-get clean

RUN pip3 install pyspark --no-cache-dir

RUN pip3 install numpy --no-cache-dir

RUN git clone https://github.com/AkasshShah/PredictOverApacheSpark.git

WORKDIR /app/PredictOverApacheSpark

# RUN ls -al

# RUN python --version

# RUN python2 --version

# RUN python3 --version

# we now have all the dependencies

RUN ./predict.sh ValidationDataset.csv
