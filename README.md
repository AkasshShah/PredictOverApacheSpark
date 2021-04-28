# Predicting using Apache Spark cluster
## _Brief introduction to Apapche Spark cluster computing on AWS_
## Here we use the some training dataset and some validation dataset that we can use to train a model to predict the last column, the `quality` column.

[![Apache Spark](https://spark.apache.org/images/spark-logo-trademark.png)](https://spark.apache.org/)

## Setup

### Pre-processing the datasets

First, the `.csv` files were not as expected. The `"`s didn't quite match up that caused issues with CSV openers. Also, in the true nature of `Comma-separated values`, the separator was changed from `;` to `,`.

Then, using tools like [csv2libsvm](https://github.com/zygmuntz/phraug/blob/master/csv2libsvm.py) to produce the libcsv files. Alternatively, we could have passed on csv files to the model, but the model was really well set-up with LIBSVM formatted files.

### Make datasets easy to access

Then, I uploaded the libsvm files to my AFS account and they can now be found [here](http://web.njit.edu/~as2757/cs643/TrainingDataset-fixed-libsvm.txt) & [here](http://web.njit.edu/~as2757/cs643/ValidationDataset-fixed-libsvm.txt) respectively. This way, it can be pulled from the web without requiring authentication.

### Make 5 ec2 instances

Well, it's just that :P. Make 5 ec2 instances (with appropriate permissions and access).

### Setting up environment

Run ```bash ./setup.sh ``` to create the environment for hadoop + spark + java. After this, type ```bash echo $CLASSPATH``` and the output should be:
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

### Decide which is master and which are slaves

## Creating the Dockerfile

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
sudo docker system prune -f && sudo docker build -t testinggggg . && sudo docker system prune -f
```
The pruning prevents dangling containers from existing.

