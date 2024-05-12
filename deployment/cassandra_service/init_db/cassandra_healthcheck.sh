
#!/bin/bash

set -e

MAX_ATTEMPTS=60
ATTEMPT_INTERVAL=5

function is_cassandra_ready() {
  nodetool status | grep -q "UN"
}

echo "Waiting for Cassandra to be ready..."
for i in $(seq 1 $MAX_ATTEMPTS); do
  if is_cassandra_ready; then
    echo "Cassandra is ready."
    exit 0
  fi
  echo "Cassandra is not ready yet. Attempt $i of $MAX_ATTEMPTS. Retrying in $ATTEMPT_INTERVAL seconds..."
  sleep $ATTEMPT_INTERVAL
done

echo "Cassandra failed to become ready within the specified time."
exit 1
