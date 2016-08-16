## Docker file to build app as container

FROM debian:jessie
MAINTAINER "Jonathan Brown" <jdbrown@usgs.gov>
LABEL dockerfile_version="v0.1.0"

# install dependencies
RUN apt-key update -y \
    && apt-get update -y \
    && apt-get install -y \
      build-essential \
      bzip2 \
      curl \
      g++ \
      git \
      make \
    && curl -o- \
      https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh \
      | /bin/bash \
    && /bin/bash -c " \
      source /root/.nvm/nvm.sh \
      && nvm install 4.2.4 \
      "

# copy application (ignores set in .dockerignore)
COPY . /earthquake-hazard-probabilistic-ws

# configure application
RUN /bin/bash -c " \
    source /root/.nvm/nvm.sh; \
    export NON_INTERACTIVE=true; \
    cd /earthquake-hazard-probabilistic-ws \
    && npm install \
    && ./src/lib/pre-install \
    && rm -r \
        /root/.npm \
        /tmp/npm* \
    "

WORKDIR /earthquake-hazard-probabilistic-ws
EXPOSE 8000
ENTRYPOINT src/lib/run
