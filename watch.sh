#!/bin/bash
TZ=Etc/UTC
ACME_FILE=/traefik/acme/acme.json

function dump() {
    SSL_DIR=/traefik/ssl/$(date '+%Z-%Y%m%d-%H%M%S')
    traefik-certs-dumper file --source "$ACME_FILE" --dest "$SSL_DIR"
}

# Run once on start
# To make sure we have any old certs
dump

inotifywait -e modify "$ACME_FILE" | while read date time dir file; do
    echo "At ${time} on ${date}, file ${dir}${file} changed"
    dump
done
