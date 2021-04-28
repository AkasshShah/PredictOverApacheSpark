FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir app

WORKDIR /app

RUN apt update && apt install -y wget python2 python3 python3-pip && apt-get clean && apt install -y default-jdk && apt-get clean

RUN pip3 install pyspark --no-cache-dir

RUN pip3 install numpy --no-cache-dir

RUN wget https://raw.githubusercontent.com/zygmuntz/phraug/master/csv2libsvm.py

RUN ls -al

# RUN python --version

RUN python2 --version

RUN python3 --version

# we now have all the dependencies
