# node-ngrok

Node.js + ngrok tunneling of a Node app port (currently using the default 3000). This docker image was developed as part of a research initiative within [Launchpad Recruits](https://www.launchpadrecruits.com), but you can change the image name and container tags according to your organisation.

## Configuring ngrok

You need a valid ngrok.yml in the working directory. Therefore create the `ngrok.yml` config file and edit its properties according to your setup. You can use the template provided:

```
cp ngrok.yml.template ngrok.yml
```

## Building the image:

```
sudo docker build . -t "node-ngrok"
```

## Usage

To start up a container execute:

```
sudo docker run -di -p 4040:4040 --name node-ngrok -v /home/jose/launchpad/blackbox/:/blackbox node-ngrok
```

To retrieve ngrok allocated subdomain run:

```
curl -s localhost:4040/api/tunnels | jq -r '.tunnels[1].public_url' 
```
