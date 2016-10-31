#!/bin/bash

npm install

su postgres -c "/usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf"

su postgres -c "/blackbox/ngrok http 3000 --config=ngrok.yml > /dev/null &"
