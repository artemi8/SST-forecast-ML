#!/bin/bash

set -e

echo "Starting Postgres..."
docker-entrypoint.sh postgres &

POSTGRES_PID=$!

# Wait for Postgres to become healthy
until pg_isready -U myuser -d airflow_db &> /dev/null; do
    echo "Postgres is unavailable - sleeping"
    sleep 1
done

echo "Postgres is up - executing custom scripts"
# Execute CQL scripts
# psql -U myuser -d result_data -f /temp/create_db.sql

#!/bin/bash

# PostgreSQL settings
DB_NAME="result_data"
DB_USER="myuser"  # Use the default 'postgres' or your custom user
DB_PASS="mypass"

# Connect to PostgreSQL server
export PGPASSWORD=$DB_PASS

# Check if the database exists
if ! psql -U "$DB_USER" -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
    # Database doesn't exist, create it
    createdb -U "$DB_USER" "$DB_NAME"
    echo "Database $DB_NAME created."
else
    echo "Database $DB_NAME already exists."
fi

SQL_SCRIPT="/docker-entrypoint-initdb.d/create_db.sql"
psql -U "$DB_USER" -d "$DB_NAME" -f "$SQL_SCRIPT"

# Now continue to foreground Cassandra process
echo "Setup complete. Bringing Postgres to the foreground..."
wait $POSTGRES_PID