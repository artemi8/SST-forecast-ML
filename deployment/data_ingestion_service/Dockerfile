FROM python:3.8

# Install necessary packages
RUN pip install pandas cdsapi cassandra-driver xarray netCDF4

# Set up working directory
WORKDIR /app

# Copy the data ingestion script and entrypoint to the container
COPY data_ingestion.py /app/data_ingestion.py
COPY entrypoint.sh /app/entrypoint.sh

# Copy the .cdsapirc file to the root home directory
COPY .cdsapirc /root/.cdsapirc

# Make the entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/app/entrypoint.sh"]
