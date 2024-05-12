#!/bin/bash

# Start the Spark shell with the --no-exit option
# /opt/bitnami/spark/bin/spark-shell --no-exit
# /opt/bitnami/spark/bin/spark-shell --no-exit --conf spark.jars.ivy=/tmp/.ivy


# Execute the command passed as argument to this script
# exec "$@"


#!/bin/bash

# Start the Spark shell with the --no-exit option
/opt/spark/bin/spark-shell --conf "spark.jars.ivy=/tmp/.ivy"

# Execute the command passed as argument to this script
exec "$@"
