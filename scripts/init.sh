#!/usr/bin/env bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`

set -a
source .env

# Create the SSL certificates for NGINX
openssl genrsa -out ./container_configuration/nginx/generated/nginx.key 2048
openssl req -new -x509 -key ./container_configuration/nginx/generated/nginx.key -out ./container_configuration/nginx/generated/nginx.crt -days 3650 -subj /CN=${PROJECT_TLD}

# Create the subdirectories for the volumes
mkdir -p ${PROJECT_VOlUME}/htdocs
mkdir -p ${PROJECT_VOlUME}/db
mkdir -p ${PROJECT_VOlUME}/elasticsearch/data
mkdir -p ${PROJECT_VOlUME}/elasticsearch/config
mkdir -p ${PROJECT_VOlUME}/bin
mkdir -p ${PROJECT_VOlUME}/home
mkdir -p ${PROJECT_VOlUME}/mongodb/data

# Enable a custom network adapter. This adapter will only last until the next
# restart but require root privileges. The adapter is required as a workaround
# on mac based environment where the docker machine can not exactly identified by
# its ip. We will create a custom adapter and route all traffic to that specific ip instead.
sudo ifconfig lo0 alias 10.200.10.1/24

# Create a permanent bash history so that you will not loose it after docker has been shut down.
if [ ! -f ${PROJECT_VOlUME}/home/.bash_history ]; then
    cp ./container_configuration/php-fpm/home/.bash_history ${PROJECT_VOlUME}/home/.bash_history
fi

# Copy the Elasticsearch configuration
cp ./container_configuration/elasticsearch/config/elasticsearch.yml ${PROJECT_VOlUME}/elasticsearch/config/elasticsearch.yml

#
envsubst < ./container_configuration/nginx/magento.template.conf > ./container_configuration/nginx/generated/magento.conf

# Script for syncing the remote database
envsubst < ./container_configuration/php-fpm/bin/syncdb.sh > ${PROJECT_VOlUME}/bin/syncdb.sh
chmod +x ${PROJECT_VOlUME}/bin/syncdb.sh