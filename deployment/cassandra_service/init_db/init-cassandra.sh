#!/bin/bash

# Continue with the default Docker entrypoint for Cassandra
# exec "$@" &

# echo "Waiting for Cassandra to start..."
# sleep 60 


# # Wait until Cassandra is ready
# until cqlsh -e "describe cluster" > /dev/null 2>&1; do
#     echo "Cassandra is unavailable - sleeping"
#     sleep 1
# done

# echo "Cassandra is up - executing command"

# # Execute CQL scripts
# cqlsh -f ./init-cassandra.cql



# Call original entrypoint to start Cassandra

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



#!/bin/bash

# set -e

# echo "Starting Cassandra..."
# /usr/local/bin/docker-entrypoint.sh &

# CASSANDRA_PID=$!

# echo "Waiting for Cassandra to be healthy..."
# while ! /bin/bash -c "./cassandra_healthcheck.sh"; do
#   sleep 1
# done

# echo "Cassandra is healthy. Running setup script..."
# /bin/bash -c "./init-cassandra.sh"

# echo "Setup complete. Bringing Cassandra to the foreground..."
# wait $CASSANDRA_PID

