FROM bitnami/spark:latest

# Add both Spark applications
ADD preprocess.py /opt/spark-apps/preprocess.py
ADD run_inference.py /opt/spark-apps/run_inference.py
COPY postgresql-42.2.6.jar /opt/bitnami/spark/jars/postgresql-42.2.6.jar
COPY RF_SST_PRED_model /opt/spark-apps/RF_SST_PRED_model

# Set the default command to keep the container alive without immediately executing a Spark job
CMD ["sleep", "infinity"]


