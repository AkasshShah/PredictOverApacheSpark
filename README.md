# Predicting using Apache Spark cluster
## _Brief introduction to Apapche Spark cluster computing on AWS_
## Here we use the some training dataset and some validation dataset that we can use to train a model to predict the last column, the `quality` column.

[![Apache Spark](https://spark.apache.org/images/spark-logo-trademark.png)](https://spark.apache.org/)

## Setup

### Pre-processing the datasets

First, the `.csv` files were not as expected. The `"`s didn't quite match up that caused issues with CSV openers. Also, in the true nature of `Comma-separated values`, the separator was changed from `;` to `,`.

Then, using tools like [csv2libsvm](https://github.com/zygmuntz/phraug/blob/master/csv2libsvm.py) to produce the libcsv files. Alternatively, we could have passed on csv files to the model, but the model was really well set-up with LIBSVM formatted files.

### Make datasets easy to access

The datasets were made part of this github-repo.

### Make 5 ec2 instances

Well, it's just that :P. Make 5 ec2 instances (with appropriate permissions and access).

### Setting up environment

Run ```./setup.sh ``` to create the environment for hadoop + spark + java. After this, type ```echo $CLASSPATH``` and the output should be:
```bash
/home/ubuntu/PredictOverApacheSpark/aws_sdk/lib/*:/home/ubuntu/PredictOverApacheSpark/aws_sdk/third-party/lib/*:/home/ubuntu/PredictOverApacheSpark/spark_bin_hadoop/jars/*
```
If it is not something like listed above, then run the following command in the terminal:
```bash
export CLASSPATH=$(pwd)/aws_sdk/lib/*:$(pwd)/aws_sdk/third-party/lib/*:$(pwd)/spark_bin_hadoop/jars/*:
```

After that, the master needs to run the following code in the terminal:
```bash
eval `ssh-agent`
ssh-add ssh_keys/node_comms
```

### Decide which is master and which are workers

First, change the ip addresses in `ip_of_workers` & in `setup.sh` to match the ip addresses of your vms.

In the master node, run
```bash
./setup-master.sh && eval `ssh-agent` && ssh-add ssh_keys/node_comms
```

### Start spark over the given 5 nodes (1 master and 4 workers)

```bash
cd spark_bin_hadoop/
./sbin/start-all.sh
```

Now spark should be running as expected over the cluster

### To train over the given data set

```bash
# cd spark_bin_hadoop/ 
# assuming that the current working directory is spark_bin_hadoop

# first we need to delete the previous save, or else it gives us an error. alternatively, we could just rename it or something...
rm ../model_save/ -rf && ./bin/spark-submit ../scripts/d_tree_c.py
```

## Creating the Dockerfile

For this section, we assume the current working directory is back to being `~/PredictOverApacheSpark/`

Install [Docker on your Ubuntu vm](https://docs.docker.com/engine/install/debian/)

### Running into the "no more space on this device error"

Try the following commands:
```bash
sudo mkdir -p /etc/sysconfig/
printf "DOCKER_STORAGE_OPTIONS= - -storage-opt dm.basesize=10G" > /etc/sysconfig/docker-storage-setup
sudo systemctl restart docker
```

And to build your docker image: try doing the following:
```bash
sudo docker system prune -f && sudo docker build -t testinggggg .
```
The pruning prevents dangling containers from existing.

This particular docker image can be found on [DockerHub](https://hub.docker.com/r/as2757/predict) as well.

## Prediction

### Predicting using the above-mentioned docker image

First we will pull the docker image

```bash
sudo docker pull as2757/predict:lmao
```

Next we run it with a file that is not in the container. First, in the VM, we have to `cd` to the place where the file is... Let's say the file we want to give in is `"file.csv"`. so we run it accordingly:

```bash
sudo docker run -it -v `pwd`:/app/PredictOverApacheSpark/blue/ as2757/predict:lmao ./predict.sh blue/file.csv
```

### Predicting without the above-mentioned docker image

It is assumed you have this git-repo cloned and the current working directory is back to being `~/PredictOverApacheSpark/`

Also, make sure python3 & python2 are installed. To check this, run:
```bash
python2 --version
python3 --version
```

After this, run:
```bash
# if you followed along from earlier, you may already have all of these installed
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y default-jre default-jdk unzip python3-pip && pip3 install pyspark numpy
```

Now, to do the prediction:
```bash
# ./predict.sh [path to file pred_data_set]
# example
./predict.sh ValidationDataset.csv
```
