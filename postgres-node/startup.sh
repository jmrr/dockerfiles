#!/bin/bash

su postgres -c "/usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf"

su postgres -c 'psql --command "ALTER USER $PGUSER WITH PASSWORD '$PGPASSWORD';"'

su postgres -c "/blackbox/ngrok http 3000 --config=ngrok.yml > /dev/null &"

export SERVER_HOST=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[1].public_url')  

npm install
