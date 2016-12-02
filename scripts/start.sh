#!/usr/bin/env bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`

set -a
source .env

#cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" --verbose up
cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up --build
#cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "${PROJECT_NAME}" up -d
