#!/bin/bash

echo "updating nginx.conf file..."

set -e

source "../.env"

DOMAIN=$(echo "$DOMAIN")
APP_NAME=$(echo "$APP_NAME")

sed -i "s/domain.localhost/${DOMAIN}/g" nginx.conf

sed -i "s/wp:9000/${APP_NAME}_wp:9000/g" nginx.conf

echo "updated nginx.conf file."