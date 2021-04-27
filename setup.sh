#!/bin/sh


# update & install all necessary packages

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y default-jre default-jdk unzip python3-pip



# no longer needed, i think

# get the aws sdk for java

# wget https://sdk-for-java.amazonwebservices.com/latest/aws-java-sdk.zip

# unzip and change the directory name to be more manageable

# x=$(unzip -qql aws-java-sdk.zip | head -n1 | tr -s ' ' | cut -d' ' -f5-)

# unzip aws-java-sdk.zip

# mv $x aws_sdk





# get spark + hadoop

wget https://apache.claz.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz

y=$(tar -tzf spark-3.1.1-bin-hadoop3.2.tgz | head -1 | cut -f1 -d"/")

tar -xvzf spark-3.1.1-bin-hadoop3.2.tgz

mv $y spark_bin_hadoop

# some cleanup

rm -rf aws-java-sdk.zip spark-3.1.1-bin-hadoop3.2.tgz




# no longer needed i think

# set CLASSPATH variable & PATH variable

# export CLASSPATH=$(pwd)/aws_sdk/lib/*:$(pwd)/aws_sdk/third-party/lib/*:$(pwd)/spark_bin_hadoop/jars/*:
# export PATH=$PATH:$(pwd)/spark_bin_hadoop/bin





# not needed to re-download files

# remove datasets if exist and re-get

# rm TrainingDataset-fixed-libsvm.txt ValidationDataset-fixed-libsvm.txt

# wget http://web.njit.edu/~as2757/cs643/TrainingDataset-fixed-libsvm.txt

# wget http://web.njit.edu/~as2757/cs643/ValidationDataset-fixed-libsvm.txt





pip3 install pyspark numpy

# super unsecure. if really gonna use this, better to create keys at runtime and not display them publicly

chmod 600 ./ssh_keys/node_comms
cat ssh_keys/node_comms.pub >> ~/.ssh/authorized_keys

# now we add the ip addresses of workers to the workers file

# we should do this manually in terminal for the master only.
# cat ip_of_workers > spark_bin_hadoop/conf/workers

