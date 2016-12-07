#!/usr/bin/env bash

set -a
source .env


ssh web-user@${REMOTE_HOST} "cd ${REMOTE_HOST_PATH}; magerun db:dump /tmp/db-dump.gz --compression=gz --add-routines --strip=\"@stripped\""
scp web-user@${REMOTE_HOST}:/tmp/db-dump.gz ./container_configuration/db/dump/db-dump.sql.gz