FROM amazonlinux:2017.03
MAINTAINER Jose Rivera <jose@gmail.com>

ENV TERM linux

## Core OS and dependencies install & configure
RUN yum -y update && \
    yum clean all && \
    yum -y install epel-release && \
    yum -y install \
        nmap-ncat \
        python-pip \
        python-devel \
        python27-devel \
        postgresql-devel \
        python-psycopg2

# build-essentials equivalent
RUN yum -y groups mark install "Development Tools" && \
    yum -y groups mark convert "Development Tools" && \
    yum -y groupinstall "Development Tools"

RUN curl https://bootstrap.pypa.io/get-pip.py | python -

# App directory
RUN mkdir -p /usr/local/src/app
WORKDIR /usr/local/src/app

# Copy data and .env though it shouldn't be necessary as Docker loads .env with compose
COPY . /usr/local/src/app

# Install API project requirements
RUN pip install --no-cache-dir -r requirements.txt

# Install app
RUN pip install .


VOLUME /usr/local/src/app

# EXPOSE 8000

# CMD ["bash",  "-c", "/usr/local/bin/gunicorn --reload -w $((2*$(nproc)+1)) -b :8000 api.wsgi:app"]

