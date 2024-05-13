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
        .options(table="era5_raw", keyspace="cds_data") \
        .load()

    # show the top five rows

    # limit the DataFrame to 5 rows
    df = df.limit(5)

    # df.show(5)
    print("SPARK LOGS : Read the data successfully")

# Drop features

    df = df.dropna(subset=["sst"])


    features_to_remove = [
        'cdir', 'msdrswrf', 'msdrswrfcs', 'msdwswrf', 'msdwswrfcs', 'msdwuvrf',
        'msnswrf', 'msnswrfcs', 'mtdwswrf', 'mtnswrf', 'mtnswrfcs', 'ssr', 'ssrc',
        'ssrdc', 'ssrd', 'tsr', 'tsrc', 'fdir'
    ]
    hand_selected_features = ['mwp', 'pp1d', 'mwd', 'swh', 'expver', 'siconc']

    df = df.drop(*features_to_remove, *hand_selected_features)

    NaN_cols = [col for col in df.columns if df.filter(df[col].isNull()).count() > 0]

    for col in NaN_cols:
        df = df.withColumn(
            col,
            last(col, ignorenulls=True).over(Window.partitionBy("latitude", "longitude").orderBy("time").rowsBetween(0, sys.maxsize))
        )


    df.write \
    .format("org.apache.spark.sql.cassandra") \
    .options(table="era5_processed", keyspace="cds_data") \
    .mode("append") \
    .save()
except AnalysisException as e:
    print("An error occurred:", e)

finally:
    spark.stop()

print("SPARK LOGS : Spark Run SUCESS")
