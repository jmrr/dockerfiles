# docker-airflow

Ubuntu Core latest + [Apache Airflow](airflow.incubator.apache.org) 1.8.0

This Dockerfile has [automated builds](https://registry.hub.docker.com/u/josemrivera/airflow/) enabled.

## Build

```
docker build --rm -t josemrivera/airflow .
```

## Usage

By default, docker-airflow runs Airflow with **SequentialExecutor** and 
**SQLite**:

```
docker run -d -p 8080:8080 josemrivera/airflow
```