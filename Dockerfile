FROM quay.io/getpantheon/debian:jessie

# pass in via "--build-arg SENSU_VERSION=..."
ARG SENSU_VERSION

# to pull from sensu's own apt repos
RUN apt-get update -y \
  && apt-get install -y \
    wget \
    apt-transport-https \
  && wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add - \
  && echo "deb     https://sensu.global.ssl.fastly.net/apt jessie main" > /etc/apt/sources.list.d/sensu.list \
  && apt-get update -y \
  && apt-get install -y \
    sensu=${SENSU_VERSION} \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*