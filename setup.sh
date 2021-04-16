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

# set CLASSPATH variable

export CLASSPATH=/home/ubuntu/PredictOverApacheSpark/aws_sdk/lib/*:/home/ubuntu/PredictOverApacheSpark/aws_sdk/third-party/lib/*
# echo $CLASSPATH

# some cleanup

rm -rf aws-java-sdk.zip
