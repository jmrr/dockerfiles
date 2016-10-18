FROM ubuntu
MAINTAINER josemrivera@gmail.com

# Add the PostgreSQL PGP key to verify their Debian packages.
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install general dependencies
RUN apt-get update &&\
    apt-get install -y \
    curl \
    git \
    unzip

# Install PostgreSQL and its dependencies
RUN apt-get install -y \
    python-software-properties \
    software-properties-common \
    postgresql-9.5 \
    postgresql-client-9.5 \
    postgresql-contrib-9.5

# Install node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

# Use ``postgres`` user
USER postgres

# Create user role with password and create a db 'blackbox'
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER deploy SUPERUSER PASSWORD 'docker';" &&\
    createdb -O deploy blackbox

USER root

# DB to allow remote connections
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.5/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/blackbox", "/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

WORKDIR /blackbox

USER postgres
# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/var/lib/postgresql/9.5/main", "-c", "config_file=/etc/postgresql/9.5/main/postgresql.conf"]

