FROM jupyter/all-spark-notebook

MAINTAINER Jose Rivera <josemrivera@gmail.com>

# Extra components for the Python stack
COPY ./requirements.txt /root/
RUN pip install -r /root/requirements.txt
RUN rm /root/requirements.txt
