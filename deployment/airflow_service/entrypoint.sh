#!/bin/bash

# Run database initialization
airflow db init

# Create default user (check if exists first, pseudo-code)

airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin


# Execute the passed command (e.g., `airflow webserver` or `airflow scheduler`)
exec "$@"
