# node

Node.js + nodemon debugging. This docker image was developed as part of a research initiative within [Launchpad Recruits](https://www.launchpadrecruits.com), but you can change the image name and container tags according to your organisation.

## Building the image:

```
sudo docker build . -t "node"
```

## Usage

To start up a container execute:

```
sudo docker run -di -p 3000:3000 -p 56745:56745 --name josemrivera/node -v /home/jose/launchpad/blackbox/:/blackbox josemrivera/node
```

### ToDo

Add switch for debug mode?

```
#!/bin/bash

# Run app
if [ "$NODE_ENV" == "development" ]
then
  npm run debug
  #node --debug=5858 app.js
else
  node app.js
fi
```
