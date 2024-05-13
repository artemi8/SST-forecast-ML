FROM postgres:latest

# COPY create_db.sql /temp/create_db.sql
COPY create_db.sql /docker-entrypoint-initdb.d/create_db.sql
COPY init-postgres.sh /docker-entrypoint-initdb.d/init-postgres.sh

# Make sure the scripts are executable
RUN chmod a+x /docker-entrypoint-initdb.d/init-postgres.sh
RUN chmod a+x /docker-entrypoint-initdb.d/create_db.sql


