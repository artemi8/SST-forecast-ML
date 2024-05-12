from pyspark.sql import SparkSession
from pyspark.ml import PipelineModel

def run_inference():
    spark = SparkSession.builder \
        .master("spark://master-node:7077") \
        .appName("ClimateDataInference") \
        .config("spark.cassandra.connection.host", "cassandra-node") \
        .getOrCreate()

    model = PipelineModel.load("/path/to/saved/model")

    cleaned_df = spark.read \
        .format("org.apache.spark.sql.cassandra") \
        .options(table="cleaned_data", keyspace="climate_keyspace") \
        .load()

    predictions = model.transform(cleaned_df)

    predictions.write \
        .format("org.apache.spark.sql.cassandra") \
        .options(table="predictions", keyspace="climate_keyspace") \
        .mode("append") \
        .save()

    spark.stop()

if __name__ == "__main__":
    run_inference()