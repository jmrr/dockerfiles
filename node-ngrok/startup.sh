#!/bin/bash

# Run ngrok to expose Node.js web server port
ngrok http 3000 --config=/ngrok.yml > /dev/null & 
sleep 2

# Set the SERVER_HOST env variable
export SERVER_HOST=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[1].public_url')  

# Install dependencies

npm install

# Run app
if [ "$NODE_ENV" == "development" ]
then
  nodemon --debug=56745 app.js
  #node --debug=5858 app.js
else
  node app.js
fi
