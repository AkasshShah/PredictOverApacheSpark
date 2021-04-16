#!/bin/sh


# update & install all necessary packages

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y default-jre default-jdk unzip

# get the aws sdk for java

wget https://sdk-for-java.amazonwebservices.com/latest/aws-java-sdk.zip

# unzip and change the directory name to be more manageable

x=$(unzip -qql aws-java-sdk.zip | head -n1 | tr -s ' ' | cut -d' ' -f5-)

unzip aws-java-sdk.zip

mv $x aws_sdk

# get spark + hadoop

wget https://apache.claz.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz

y=$(tar -tzf spark-3.1.1-bin-hadoop2.7.tgz | head -1 | cut -f1 -d"/")

tar -xvzf spark-3.1.1-bin-hadoop2.7.tgz

mv $y spark_bin_hadoop

# some cleanup

rm -rf aws-java-sdk.zip spark-3.1.1-bin-hadoop2.7.tgz

# set CLASSPATH variable

export CLASSPATH=$(pwd)/aws_sdk/lib/*:$(pwd)/aws_sdk/third-party/lib/*:$(pwd)/spark_bin_hadoop/jars/*
