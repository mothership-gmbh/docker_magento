#!/usr/bin/env bash


set -a
source .env

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`
docker rm -v $(docker ps -a -q -f status=exited)
docker images -q --filter dangling=true | xargs docker rmi

# clean up volumes
docker volume rm $(docker volume ls -qf dangling=true)