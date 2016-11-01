# Node.js + PostgreSQL with ngrok tunneling

This docker image was developed as part of a research initiative within [Launchpad Recruits](https://www.launchpadrecruits.com), but you can change the image name and container tags according to your organisation.


## Build your image

```
sudo docker build . -t "launchpad/blackbox
```

## Create your `.env` file:

Add environment variables for your configuration in a `.env` file in a `VAR=VAL` format.


## Run your container and drop to a shell within

```
sudo docker run -ti --rm -p 5432:5432 -p 4040:4040 --env-file=.env --name blackbox -v /home/jose/launchpad/blackbox/:/blackbox launchpad/blackbox bash
```


```
PGUSER=deploy PGDATABASE=blackbox PGPASSWORD=docker node create-tables.js
```
curl localhost:4040/api/tunnels


This will effectively expose ports 5432 for Postgres and 4040 for the ngrok API.
