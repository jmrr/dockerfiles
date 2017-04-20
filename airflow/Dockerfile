FROM ubuntu:latest
MAINTAINER Jose Rivera <josemrivera@gmail.com> 

ENV TERM linux

# Airflow
ARG AIRFLOW_VERSION=1.8.0

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    python-pip \
    python-dev \
    python-setuptools \
    build-essential

# Airflow
RUN pip install airflow

# Cleanup
RUN apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

# Initialise db
RUN airflow initdb

ENV AIRFLOW_HOME /airflow
WORKDIR /airflow

EXPOSE 8080
CMD ["airflow","webserver","-p","8080"]
