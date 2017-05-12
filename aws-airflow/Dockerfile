FROM amazonlinux:2016.09
MAINTAINER Jose Rivera <jose@launchpadrecruits.com>

ENV TERM linux

# Airflow args and env vars
ARG AIRFLOW_VERSION=1.8.0
ARG AIRFLOW_HOME=/usr/local/airflow

## Core OS and dependencies install & configure
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install \
        nmap-ncat \
        python-pip \
        python-devel \
        python27-devel \
        krb5-devel \
        openssl-devel \
        cyrus-sasl-devel \
        libffi-devel \
        which \
        postgresql-devel \
        python-psycopg2

# build-essentials equivalent
RUN yum -y groups mark install "Development Tools" && \
    yum -y groups mark convert "Development Tools" && \
    yum -y groupinstall "Development Tools"

RUN groupadd -r airflow &&
    useradd -ms /bin/bash -d ${AIRFLOW_HOME} -g airflow airflow

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python -

# Airflow
RUN pip install airflow[crypto,postgres]==$AIRFLOW_VERSION

# Cleanup
RUN yum clean all \
    && rm -rf \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

# Adjust ownership and permissions
RUN chown -R airflow:airflow ${AIRFLOW_HOME}
RUN chmod +x /entrypoint.sh

EXPOSE 8080

# USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
