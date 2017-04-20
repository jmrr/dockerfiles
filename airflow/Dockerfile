FROM ubuntu:latest
MAINTAINER Jose Rivera <josemrivera@gmail.com> 

ENV TERM linux

# Airflow args and env vars
ARG AIRFLOW_VERSION=1.8.0
ARG AIRFLOW_HOME=/usr/local/airflow

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    python-pip \
    python-dev \
    python-setuptools \
    build-essential \
    libffi-dev \
    libssl-dev \
    apt-utils \
    git \
    netcat \
    curl \
    libpq-dev \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow


# Airflow
RUN python -m pip install -U pip \
    && pip install airflow[crypto,postgres]==$AIRFLOW_VERSION \
    && pip install psycopg2

# Cleanup
RUN apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

# Adjust ownership and permissions
RUN chown -R airflow: ${AIRFLOW_HOME}
RUN chmod +x /entrypoint.sh

EXPOSE 8080

USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
