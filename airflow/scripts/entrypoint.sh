#!/usr/bin/env bash

AIRFLOW_HOME="/usr/local/airflow"
CMD="airflow"
TRY_LOOP="20"


: ${POSTGRES_HOST:="postgres"}
: ${POSTGRES_PORT:="5433"}
: ${POSTGRES_USER:="airflow"}
: ${POSTGRES_PASSWORD:="airflow"}
: ${POSTGRES_DB:="airflow"}

# Fernet secret key for encryption when saving connection passwords in the db
: ${FERNET_KEY:=$(python -c "from cryptography.fernet import Fernet; FERNET_KEY = Fernet.generate_key().decode(); print(FERNET_KEY)")}

# Load DAGs exemples (default: Yes)
if [ "$LOAD_EX" = "n" ]; then
    sed -i "s/load_examples = True/load_examples = False/" "$AIRFLOW_HOME"/airflow.cfg
fi

# Install custom python package if requirements.txt is present
if [ -e "/requirements.txt" ]; then
    $(which pip) install --user -r /requirements.txt
fi

# Update airflow config - Fernet key
sed -i "s|\$FERNET_KEY|$FERNET_KEY|" "$AIRFLOW_HOME"/airflow.cfg

# Wait for Postresql
if [ "$1" = "webserver" ] ; then
  i=0
  while ! nc -z $POSTGRES_HOST $POSTGRES_PORT >/dev/null 2>&1 < /dev/null; do
    i=$((i+1))
    if [ "$1" = "webserver" ]; then
      echo "$(date) - waiting for ${POSTGRES_HOST}:${POSTGRES_PORT}... $i/$TRY_LOOP"
      if [ $i -ge $TRY_LOOP ]; then
        echo "$(date) - ${POSTGRES_HOST}:${POSTGRES_PORT} still not reachable, giving up"
        exit 1
      fi
    fi
    sleep 10
  done
fi

# By default use LocalExecutor
sed -i "s#sql_alchemy_conn = postgresql+psycopg2://airflow:airflow@postgres/airflow#sql_alchemy_conn = postgresql+psycopg2://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB#" "$AIRFLOW_HOME"/airflow.cfg
sed -i "s#broker_url = redis://redis:6379/1#broker_url = redis://$REDIS_HOST:$REDIS_PORT/1#" "$AIRFLOW_HOME"/airflow.cfg
echo "Initialize database..."
$CMD initdb
exec $CMD webserver &
exec $CMD scheduler
