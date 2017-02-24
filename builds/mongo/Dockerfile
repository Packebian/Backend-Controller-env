# Build a docker container containing a mongodb
FROM mongo:latest
MAINTAINER Rémi GATTAZ <remi.gattaz@gmail.com>

ADD run.sh /run.sh

# Envrionment
ENV ADMIN_USER="root" \
    ADMIN_PASS="mongdb123" \
    MONGO_DB="packebian" \
    MONGO_USER="packebian" \
    MONGO_PASS="packebian123"

# Start application
CMD /run.sh
