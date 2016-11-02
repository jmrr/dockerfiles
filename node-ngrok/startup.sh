#!/bin/bash

# Run ngrok to expose Node.js web server port
ngrok http 3000 --config=/ngrok.yml > /dev/null & 
sleep 2

# Set the SERVER_HOST env variable
export SERVER_HOST=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[1].public_url')  

# Create tables
node create-tables.js
# Create API key
node scripts/createApiKey.js --role rw --key testkey

# Run app

node app.js
