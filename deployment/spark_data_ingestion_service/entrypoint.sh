#!/bin/bash

# Execute the command passed as argument to this script
# if [ -z "$1" ]; then
#     echo "No command passed as argument. Executing default command: python /app/data_ingestion.py"
#     exec python /app/data_ingestion.py
# else
#     echo "Executing command passed as argument: $@"
#     exec "$@"
# fi

#!/bin/bash

# echo "Executing data ingestion script: python /app/data_ingestion.py"
# exec python /app/data_ingestion.py

# Wait for a command to be passed as an argument
while [ -z "$1" ]; do
    echo "Waiting for a command to be passed as an argument..."
    sleep 5
done

# Execute the command passed as an argument
echo "Executing command passed as argument: $@"
exec "$@"