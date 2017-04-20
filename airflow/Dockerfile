FROM ubuntu:latest
MAINTAINER Jose Rivera <josemrivera@gmail.com> 

ENV TERM linux

# Airflow args and env vars
ARG AIRFLOW_VERSION=1.8.0
ARG AIRFLOW_HOME=/usr/local/airflow

# Assuming local executor
ENV EXECUTOR Local

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    python-pip \
    python-dev \
    python-setuptools \
    build-essential \
    libffi-dev \
    libssl-dev \
    git \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow


# Airflow
RUN python -m pip install -U pip \
    && pip install airflow[crypto,password,postgres]==$AIRFLOW_VERSION

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

RUN chown -R airflow: ${AIRFLOW_HOME}

EXPOSE 8080 5555 8793

USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
