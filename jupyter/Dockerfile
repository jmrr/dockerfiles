FROM jupyter/all-spark-notebook

MAINTAINER Jose Rivera <josemrivera@gmail.com>

USER root

RUN apt-get update
RUN apt-get install -y libpq-dev

# Extra components for the Python stack
COPY ./requirements.txt /home/jovyan/
RUN pip install -r /home/jovyan/requirements.txt
RUN rm /home/jovyan/requirements.txt
