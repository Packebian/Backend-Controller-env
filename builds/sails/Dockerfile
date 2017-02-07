# Build a docker container containing the sails framework
FROM node:latest

MAINTAINER Rémi GATTAZ <remi.gattaz@gmail.com>

# Define mountable directories.
VOLUME ["/srv/sails"]

# Define working directory.
WORKDIR /srv/sails

# Expose sails default port
EXPOSE 1337

# Install sails
RUN npm install -g sails forever

# generate a sails app if needed
RUN if [ ! -f package.json ]; then sails new .; fi

# Start application
CMD /bin/bash -c 'forever app.js'
