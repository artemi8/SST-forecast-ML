FROM bitnami/spark:latest

# Add both Spark applications
ADD preprocess.py /opt/spark-apps/preprocess.py
ADD run_inference.py /opt/spark-apps/run_inference.py


# Set the default command to keep the container alive without immediately executing a Spark job
CMD ["sleep", "infinity"]

# FROM apache/spark:latest

# Copy the preprocessing script
# COPY preprocess.py /app/preprocess.py

# Copy the entrypoint script to the container
# COPY entrypoint.sh /app/entrypoint.sh

# Make the entrypoint script executable

# USER root 
# RUN chmod +x /app/entrypoint.sh
# Set the SPARK_LOCAL_DIRS environment variable
# ENV SPARK_LOCAL_DIRS /tmp/spark-local

# USER 1001

# Set the entrypoint to the script
# ENTRYPOINT ["/app/entrypoint.sh"]
