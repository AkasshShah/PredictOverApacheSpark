from pyspark.ml import Pipeline
from pyspark.ml.classification import DecisionTreeClassifier
from pyspark.ml.feature import StringIndexer, VectorIndexer
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml import PipelineModel
from pyspark.sql import SparkSession

if __name__ == "__main__":
    spark = SparkSession\
        .builder\
        .appName("d_tree_c")\
        .getOrCreate()
    
    # Load the data stored in LIBSVM format as a DataFrame.
    data = spark.read.format("libsvm").load("../all_dataset-fixed-libsvm.txt")

    # Index labels, adding metadata to the label column.
    # Fit on whole dataset to include all labels in index.
    labelIndexer = StringIndexer(inputCol="label", outputCol="indexedLabel").fit(data)
    # Automatically identify categorical features, and index them.

    featureIndexer = VectorIndexer(inputCol="features", outputCol="indexedFeatures", maxCategories=10).fit(data)

    # featureIdexer = VectorIndexer(inputCol="features", outputCol="indexedFeatures", maxCategories=10).fit(data)

    # Split the data into training and test sets (30% held out for testing)
    # (trainingData, testData) = data.randomSplit([0.7, 0.3])
    trainingData = spark.read.format("libsvm").load("../TrainingDataset-fixed-libsvm.txt")
    testData = spark.read.format("libsvm").load("../ValidationDataset-fixed-libsvm.txt")

    # Train a DecisionTree model.
    dt = DecisionTreeClassifier(labelCol="indexedLabel", featuresCol="indexedFeatures")

    # Chain indexers and tree in a Pipeline
    pipeline = Pipeline(stages=[labelIndexer, featureIndexer, dt])

    # Train model.  This also runs the indexers.
    model = pipeline.fit(trainingData)

    # save
    model.save("../model_save")

    # Make predictions.
    predictions = model.transform(testData)

    # Select example rows to display.
    predictions.select("prediction", "indexedLabel", "features").show(5)

    # Select (prediction, true label) and compute test error
    evaluator = MulticlassClassificationEvaluator(labelCol="indexedLabel", predictionCol="prediction", metricName="f1")
    f1 = evaluator.evaluate(predictions)
    print("f1 score = %g " % f1)

    treeModel = model.stages[2]
    # summary only
    print(treeModel)
    # $example off$

    spark.stop()
