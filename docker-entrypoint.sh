#!/bin/sh

mkdir -p /home/rancher-cli/.rancher

[ -f /home/rancher-cli/.rancher/cli.json ] && echo "Found /home/rancher-cli/.rancher/cli.json" || echo "{\"accessKey\":\"$ACCESS_KEY\",\"secretKey\":\"$SECRET_KEY\",\"url\":\"$URL\",\"environment\":\"$ENV\"}" > /home/rancher-cli/.rancher/cli.json
exec "$@"
