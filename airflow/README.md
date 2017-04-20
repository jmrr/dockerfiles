# docker-airflow

Ubuntu Core latest + [Apache Airflow](airflow.incubator.apache.org) 1.8.0. A 
multi-container application setup is also provided in this repo, using the 
official [PostgreSQL](https://hub.docker.com/_/postgres/) image as database 
backend for Airflow.

This Dockerfile is based on the more complete by [puckel](https://github.com/puckel/docker-airflow).

[Automated builds](https://registry.hub.docker.com/u/josemrivera/airflow/) have 
been enabled for the main image `josemrivera/airflow`.

## Requirements

* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/install/) for the 
multi-container app.

## Build

```
docker build --rm -t josemrivera/airflow .
```

## Usage

For now `josemrivera/airflow` is written to be run as a multi-container Docker
application using `docker-compose`. To run Airflow with the Postgres backend:

```
docker-compose up -d     
```

This needs `sudo` if the user hasn't been added to the `docker` group.

NB : If you don't want to have DAGs example loaded (default=True), you must set 
the following environment variable `LOAD_EX=n` in the `docker-compose.yml` file.


If you want to use Adhoc query, make sure you've configured connections:
Go to Admin -> Connections and Edit "postgres_default" set this values 
(equivalent to values in airflow.cfg/docker-compose.yml) :
- Host : postgres
- Schema : airflow
- Login : airflow
- Password : airflow

For encrypted connection passwords, you must have the same fernet_key. By 
default docker-airflow generates the fernet_key at startup, you have to set an 
environment variable in the `docker-compose.yml` file to set the same key across 
containers. To generate a fernet_key :

```bash
python -c "from cryptography.fernet import Fernet; FERNET_KEY = Fernet.generate_key().decode(); print FERNET_KEY"
```

Check [Airflow Documentation](https://pythonhosted.org/airflow/)

## Install custom python packages

- Create a file "requirements.txt" with the desired python modules
- Mount this file as a volume `-v $(pwd)/requirements.txt:/requirements.txt`
- The `entrypoint.sh` script executes the `pip install -r` command (with --user option)

## UI Links

- Airflow: [localhost:8888](http://localhost:8888/)

When using OSX with `boot2docker`, use: `open http://$(boot2docker ip):8888`