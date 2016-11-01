#!/bin/bash

# Run ngrok to expose Node.js web server port
ngrok http 3000 --config=/ngrok.yml > /dev/null 
