from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from pyspark.sql.utils import AnalysisException
from pyspark.sql.functions import col, last
from pyspark.sql.window import Window
import sys

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
        .options(table="era5_processed", keyspace="cds_data") \
        .load()

    # show the top five rows

    # limit the DataFrame to 5 rows
    df = df.limit(5)

    # df.show(5)
    print("SPARK LOGS : Read the data successfully")

    postgres_df = df.select(
        col("time"),
        col("sst"),
        col("latitude"),
        col("longitude")
    ).withColumn("95_lower_bound_CI", col("sst") * 0.95 
    ).withColumn("95_upper_bound_CI", col("sst") * 1.05)\
    .withColumn("99_lower_bound_CI", col("sst") * 0.90)\
    .withColumn("99_upper_bound_CI", col("sst") * 1.10)\
    
    print("Connecting to Postgres")
    
    # Database connection parameters
    url = "jdbc:postgresql://postgres-db:5432/result_data"
    properties = {
        "user": "myuser",
        "password": "mypass",
        "driver": "org.postgresql.Driver"
    }

    # Write the DataFrame to PostgreSQL
    try:
        postgres_df.write.jdbc(url=url, table="sst_era5", mode="append", properties=properties)
        print("Data written to PostgreSQL successfully!")
    except Exception as e:
        print("Failed to write data to PostgreSQL:", e)
except AnalysisException as e:
    print("An error occurred:", e)

finally:
    spark.stop()

print("SPARK LOGS : Spark Run SUCESS")
