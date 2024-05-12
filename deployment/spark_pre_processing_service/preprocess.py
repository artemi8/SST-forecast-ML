from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from pyspark.sql.utils import AnalysisException


    # create a SparkSession
print("SPARK LOGS : Starting Spark Run")
spark = SparkSession.builder \
    .appName("ClimateDataPreprocessing") \
    .config("spark.cassandra.connection.host", "cassandra") \
    .config("spark.cassandra.connection.port", "9042") \
    .getOrCreate()

try:
# read data from Cassandra
    df = spark.read.format("org.apache.spark.sql.cassandra") \
        .options(table="era5_raw", keyspace="cds_data") \
        .load()

    # show the top five rows

    # limit the DataFrame to 5 rows
    df = df.limit(5)

    # df.show(5)
    print("SPARK LOGS : Read the data successfully")

    df.write \
    .format("org.apache.spark.sql.cassandra") \
    .options(table="era5_raw", keyspace="cds_data") \
    .mode("append") \
    .save()
except AnalysisException as e:
    print("An error occurred:", e)

finally:
    spark.stop()

print("SPARK LOGS : Spark Run SUCESS")
