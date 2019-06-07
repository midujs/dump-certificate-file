FROM ubuntu:18.04

RUN  apt-get update \
  && apt-get install --yes inotify-tools \
  && rm -rf /etc/apt/sources.list.d/*

# Add traefik-certs-dumper binary
COPY traefik-certs-dumper /usr/bin/traefik-certs-dumper

# Run watch
WORKDIR /traefik

COPY watch.sh .
CMD ["./watch.sh"]
