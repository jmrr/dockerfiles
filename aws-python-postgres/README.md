# Python + PostgreSQL
Default Linux distro: AMI Linux

## Build your image
```
sudo docker build . -t "josemrivera/python-postgres
```

## Create your `.env` file:
Add environment variables for your configuration in a `.env` file in a `VAR=VAL` format.


## Run your container and drop to a shell within
```
sudo docker run -ti --rm --env-file=.env --name python-postgres x-v /home/jose/code/app/:/usr/local/src/app josemrivera/python-postgres bash
```

