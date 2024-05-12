from pyspark.sql import SparkSession
from pyspark.conf import SparkConf

def create_spark_session():
     conf = SparkConf()\
        .set("fs.azure", "org.apache.hadoop.fs.azure.NativeAzureFileSystem")\
        .set("fs.azure.account.key.<your-account-name>.dfs.core.windows.net", "<your-access-key>")
     
     spark = SparkSession.builder.appName("AzureDLGen2Access")\
        .config(conf=conf)\
        .getOrCreate()
     return spark

def read_csv_from_adls(spark, file_path):
    df = spark.read.csv(file_path, header=True, inferSchema=True)
    return df

if __name__ == "__main__":
    spark = create_spark_session()
    file_path = "/mnt/2024-team8/dengue_features_train.csv"
    df = read_csv_from_adls(spark, file_path)
    df.show()

