#!/bin/bash

set -e

echo "Starting Cassandra..."
/usr/local/bin/docker-entrypoint.sh &

CASSANDRA_PID=$!

# Wait for Cassandra to become healthy
until cqlsh -e "describe cluster" > /dev/null 2>&1; do
    echo "Cassandra is unavailable - sleeping"
    sleep 1
done

echo "Cassandra is up - executing custom scripts"
# Execute CQL scripts
cqlsh -f /docker-entrypoint-initdb.d/init-cassandra.cql

# Now continue to foreground Cassandra process
echo "Setup complete. Bringing Cassandra to the foreground..."
wait $CASSANDRA_PID


