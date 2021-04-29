import os
import sys
from pyspark.ml import Pipeline
from pyspark.ml.regression import RandomForestRegressor
from pyspark.ml.feature import VectorIndexer
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.sql import SparkSession
from pyspark.ml import PipelineModel
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark import SparkConf
from pyspark import SparkContext
from pyspark.mllib.clustering import KMeans, KMeansModel


if __name__ == "__main__":

    sconf = SparkConf().setAppName("how_good_is_it").set('spark.sql.warehouse.dir', 'file://opt/spark/spark-warehouse/')
    sc = SparkContext(conf=sconf)  # SparkContext
    spark = SparkSession.builder.appName("how_good_is_it").getOrCreate()

    testData = spark.read.format("libsvm").load(sys.argv[1])

    model = PipelineModel.load("model_save/")

    # Make predictions.
    predictions = model.transform(testData)

    # Select example rows to display.
    predictions.select("prediction", "label", "features").show(5)

    # Select (prediction, true label) and compute test error
    evaluator = MulticlassClassificationEvaluator(labelCol="indexedLabel", predictionCol="prediction", metricName="f1")
    
    f1Measure = evaluator.evaluate(predictions)
    print("f1 measure on test data = %g" % f1Measure)

    # rfModel = model.stages[1]
    # print(rfModel)  # summary only
    # $example off$

    sc.stop()
    spark.stop()
