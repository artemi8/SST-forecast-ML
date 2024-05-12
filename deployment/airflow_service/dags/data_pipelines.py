from airflow import DAG
from airflow.providers.docker.operators.docker import DockerOperator
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator
# from airflow.contrib.operators.spark_submit_operator import SparkSubmitOperator
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=1),
}



t1 =  DAG('ingestion_to_inference',
                default_args=default_args,
                schedule_interval=timedelta(days=1),
                    start_date=days_ago(2))

data_ingestion_task = BashOperator(
    task_id='data_ingestion',
    bash_command='docker exec deployment-data-ingestion-service-1 python /app/data_ingestion.py',
    dag=t1
    )

# spark_command = '/opt/spark/bin/spark-submit --master spark://spark-master:7077 --deploy-mode client'
spark_command = 'spark-submit \
        --deploy-mode client \
        --driver-memory 1g \
        --executor-memory 2g \
        --executor-cores 2 \
        --packages com.datastax.spark:spark-cassandra-connector_2.12:3.0.0'

preprocess = BashOperator(
    task_id='preprocess_data',
    bash_command=f'docker exec deployment-spark-master-1 {spark_command} /opt/spark-apps/preprocess.py',
    dag=t1
    )

# preprocess = SparkSubmitOperator(
#     task_id='preprocess_data',
#     application='/opt/spark-apps/preprocess.py',
#     name='preprocess_job',
#     conn_id='spark_default',
#     verbose=True,
#     dag=t1,
# )

data_ingestion_task >> preprocess


# t2 = DAG(
#     'spark_processing_pipeline',
#     default_args=default_args,
#     description='A simple pipeline that processes data and runs inference using Spark',
#     schedule_interval=None,
# )
# inference = SparkSubmitOperator(
#     task_id='run_inference',
#     application='/opt/spark-apps/run_inference.py',
#     name='inference_job',
#     conn_id='spark_default',
#     dag=dag,
# )
# t2 = DAG(
#     'my_spark_dag',
#     default_args=default_args,
#     description='Spark Preprocessing service',
#     schedule_interval=timedelta(days=1),
# )

# spark_task = BashOperator(
#     task_id='spark_task_preprocessing',
#     bash_command='spark-submit /preprocess.py',
#     dag=t2,
# )


# Preprocess data task
# t2 = DockerOperator(
#     task_id='preprocess_data',
#     image='data_preprocessing_service',
#     container_name='preprocess_data_container',
#     auto_remove=True,
#     command=["spark-submit", "/app/preprocess.py"],
#     dag=dag,
# )

# # Run inference task
# t3 = DockerOperator(
#     task_id='run_inference',
#     image='inference_service',
#     container_name='run_inference_container',
#     auto_remove=True,
#     command=["spark-submit", "/app/run_inference.py"],
#     dag=dag,
# )

# t1 >> t2 >> t3


# dag = DAG(
#     'climate_data_pipeline',
#     default_args=default_args,
#     description='A big data pipeline for climate data using Airflow',
#     schedule_interval=timedelta(days=1),
#     start_date=days_ago(2),
# )

# # Ingest data task
# ingest_data = DockerOperator(
#     task_id='ingest_data',
#     image='data_ingestion_image:latest',  # Ensure this is the correct image name as specified in your Docker compose or Dockerfile
#     container_name='data-ingestion-service-2',
#     command="python /app/data_ingestion.py",
#     network_mode="deployment_airflow-network",  # Ensure this is the same network as specified in your docker-compose.yml
#     docker_url="unix://var/run/docker.sock",
#     auto_remove=True,
#     dag=dag,
# )