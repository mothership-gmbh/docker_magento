#!/usr/bin/env bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`

export DOCKER_IP=$(dlite ip)


set -a
source .env


# create the subdirectories for the volumes
mkdir -p ${PROJECT_VOlUME}/htdocs
mkdir -p ${PROJECT_VOlUME}/db
mkdir -p ${PROJECT_VOlUME}/elasticsearch/data
mkdir -p ${PROJECT_VOlUME}/elasticsearch/config
mkdir -p ${PROJECT_VOlUME}/apache2

cp ./elasticsearch/config/elasticsearch.yml ${PROJECT_VOlUME}/elasticsearch/config/elasticsearch.yml
cp ./apache/host.conf <> ${PROJECT_VOlUME}/elasticsearch/config/elasticsearch.yml

envsubst < ./apache/host.conf > ${PROJECT_VOlUME}/apache2/${PROJECT_NAME}.conf


cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up
#cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up --build
#cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up -d
