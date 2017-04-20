# docker-airflow

Ubuntu Core latest + [Apache Airflow](airflow.incubator.apache.org)

This Dockerfile has [automated builds](https://registry.hub.docker.com/u/josemrivera/airflow/) enabled.

## Build

```
docker build --rm -t josemrivera/docker-airflow .
```

## Usage

By default, docker-airflow runs Airflow with **SequentialExecutor** and 
**SQLite**:

```
docker run -d -p 8080:8080 josemrivera/docker-airflow
```