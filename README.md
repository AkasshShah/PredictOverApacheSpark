# Predicting using Apache Spark cluster
## _Brief introduction to Apapche Spark cluster computing on AWS_
## Here we use the some training dataset and some validation dataset that we can use to train a model to predict the last column, the `quality` column.

[![Apache Spark](https://spark.apache.org/images/spark-logo-trademark.png)](https://spark.apache.org/)

## Setup

### Fix downloaded datasets

First, the `.csv` files were not as expected. The `"`s didn't quite match up that caused issues with CSV openers. Also, in the true nature of `Comma-separated values`, the separator was changed from `;` to `,`.

### Make datasets easy to access

Then, I uploaded the `TrainingDataset-fixed.csv` & `ValidationDataset-fixed.csv` to my AFS account and they can now be found [here](http://web.njit.edu/~as2757/cs643/TrainingDataset-fixed.csv) & [here](http://web.njit.edu/~as2757/cs643/ValidationDataset-fixed.csv) respectively. This way, it can be pulled from the web without requiring authentication.
