#!/usr/bin/env bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`



set -a
source .env


# create the subdirectories for the volumes
mkdir -p ${PROJECT_VOlUME}/htdocs
mkdir -p ${PROJECT_VOlUME}/db
mkdir -p ${PROJECT_VOlUME}/elasticsearch
mkdir -p ${PROJECT_VOlUME}/elasticsearch/data
mkdir -p ${PROJECT_VOlUME}/elasticsearch/config
mkdir -p ${PROJECT_VOlUME}/apache2
mkdir -p ${PROJECT_VOlUME}/home
mkdir -p ${PROJECT_VOlUME}/php
mkdir -p ${PROJECT_VOlUME}/varnish/conf.d
mkdir -p ${PROJECT_VOlUME}/bin

sudo ifconfig lo0 alias 10.200.10.1/24


if [ ! -f ${PROJECT_VOlUME}/home/.bash_history ]; then
    echo "Create bash history!"
    cp ./home/.bash_history ${PROJECT_VOlUME}/home/.bash_history
fi

# copy the elasticsearch configuration
cp ./elasticsearch/config/elasticsearch.yml ${PROJECT_VOlUME}/elasticsearch/config/elasticsearch.yml

# Varnish pain
cp ./varnish/conf.d/default.vcl ${PROJECT_VOlUME}/varnish/conf.d/default.vcl

cp ./apache/ports.conf ${PROJECT_VOlUME}/apache2/ports.conf

envsubst < ./apache/host.conf > ${PROJECT_VOlUME}/apache2/${PROJECT_NAME}.conf

# Script for syncing the remote database
envsubst < ./scripts/syncdb.sh > ${PROJECT_VOlUME}/bin/syncdb.sh
chmod +x ${PROJECT_VOlUME}/bin/syncdb.sh

#cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" --verbose up
cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up --build
#cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up -d
