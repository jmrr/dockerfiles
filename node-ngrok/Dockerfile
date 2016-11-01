FROM node
MAINTAINER josemrivera@gmail.com

# Install general dependencies
RUN apt-get update &&\
    apt-get install -y \
    unzip 

# Download and extract ngrok
RUN curl -o ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip 
RUN unzip ngrok.zip -d /usr/local/bin/

# Copy ngrok configuration file
COPY ngrok.yml /

# Copy startup script and make executable
COPY startup.sh /
RUN chmod 755 /startup.sh

# Declare which script will be run when starting up the container
ENTRYPOINT ["/bin/bash", "/startup.sh"]

# Expose ngrok port for Node app
EXPOSE 4040

VOLUME ["/blackbox"]

WORKDIR /blackbox

