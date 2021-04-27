#!/bin/sh

eval `ssh-agent`

ssh-add ssh_keys/node_comms

cat ip_of_workers > spark_bin_hadoop/conf/workers

# replace with the IP address of your master

echo "spark.master                     spark://172.31.84.38:7077" > spark_bin_hadoop/conf/spark-defaults.conf

