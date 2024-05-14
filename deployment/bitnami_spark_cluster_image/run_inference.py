from pyspark.sql import SparkSession
from pyspark.sql.utils import AnalysisException
from pyspark.sql.functions import lag, col, to_timestamp, year, month, day, hour, last, first, coalesce, date_format, avg, when
from pyspark.sql.window import Window
from pyspark.ml.feature import VectorAssembler, RobustScaler
from pyspark.ml.pipeline import PipelineModel
from pyspark.ml.evaluation import RegressionEvaluator
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
    df = df.limit(30)

    # df.show(5)
    print("SPARK LOGS : Read the data successfully")

    # Load the model
    model_path = './RF_SST_PRED_model'  # Replace with your actual model path
    loaded_model = PipelineModel.load(model_path)
    print("Model loaded successfully.")

    split_year_test = 2021
    df = df.filter(year(df['time']) >= split_year_test).cache()

    # Convert time column to timestamp and add time-based features
    df = df.withColumn("time", to_timestamp("time")).orderBy("time", "latitude", "longitude")
    df = df.withColumn("year", year("time"))
    df = df.withColumn("month", month("time"))
    df = df.withColumn("day", day("time"))
    df = df.withColumn("hour", hour("time"))

    # Define window specifications for lag features
    windowSpec = Window.partitionBy("latitude", "longitude").orderBy("time")

    # Adding initial lag features; stepsize :3
    df = df.withColumn("sst_lag_3_months", lag("sst", 9).over(windowSpec))
    df = df.withColumn("sst_lag_12_months", lag("sst", 36).over(windowSpec))

    # Define window specifications for forward and backward fill
    windowSpecForward = Window.partitionBy("latitude", "longitude").orderBy("time").rowsBetween(Window.unboundedPreceding, Window.currentRow)
    windowSpecBackward = Window.partitionBy("latitude", "longitude").orderBy(col("time").desc()).rowsBetween(Window.unboundedPreceding, Window.currentRow)

    # Applying forward fill using last and backward fill using first, but only filling nulls

    #For sst_lag_3_months
    df = df.withColumn("sst_lag_3_months_ffill", when(col("sst_lag_3_months").isNull(), last("sst_lag_3_months", ignorenulls=True).over(windowSpecForward)).otherwise(col("sst_lag_3_months")))
    df = df.withColumn("sst_lag_3_months_filled", when(col("sst_lag_3_months_ffill").isNull(), first("sst_lag_3_months_ffill", ignorenulls=True).over(windowSpecBackward)).otherwise(col("sst_lag_3_months_ffill")))

    # For sst_lag_12_months
    df = df.withColumn("sst_lag_12_months_ffill", when(col("sst_lag_12_months").isNull(), last("sst_lag_12_months", ignorenulls=True).over(windowSpecForward)).otherwise(col("sst_lag_12_months")))
    df = df.withColumn("sst_lag_12_months_filled", when(col("sst_lag_12_months_ffill").isNull(), first("sst_lag_12_months_ffill", ignorenulls=True).over(windowSpecBackward)).otherwise(col("sst_lag_12_months_ffill")))

    # Drop unnecessary columns
    df = df.drop("sst_lag_3_months", "sst_lag_3_months_ffill", "sst_lag_12_months", "sst_lag_12_months_ffill")

    # Filter out rows with null values in the filled lag columns
    test_data = df.na.drop(subset=["sst_lag_12_months_filled"])

    # Feature Engineering - RobustScaler and VectorAssembler
    # features to scale
    initial_feature_cols = [col for col in test_data.columns if col not in ["time", "sst", "longitude", "latitude"]]
    initial_assembler = VectorAssembler(inputCols=initial_feature_cols, outputCol="initial_features")

    # Robust scaler
    scaler = RobustScaler(inputCol="initial_features", outputCol="scaled_features")

    # Assemble final feature columns including scaled features, longitude, and latitude
    final_assembler = VectorAssembler( inputCols=["longitude","latitude","scaled_features"],outputCol="features" )

    # Use the loaded model for prediction
    predictions = loaded_model.transform(test_data)

    postgres_df = predictions.select(
        col("time"),
        col("prediction"),
        col("latitude"),
        col("longitude")
    ).withColumn("95_lower_bound_CI", col("prediction") * 0.95 
    ).withColumn("95_upper_bound_CI", col("prediction") * 1.05)\
    .withColumn("99_lower_bound_CI", col("prediction") * 0.90)\
    .withColumn("99_upper_bound_CI", col("prediction") * 1.10)\
    
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
