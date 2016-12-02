#!/usr/bin/env bash
cd /root/.ssh
eval `ssh-agent`
ssh-add /root/.ssh/id_rsa
cd /var/www/share/dev/htdocs/www
modman deploy-all --force
ssh ${REMOTE_HOST} "cd ${REMOTE_HOST_PATH}; magerun db:dump /tmp/db-dump.gz --compression=gz --strip=\"@stripped\""
scp ${REMOTE_HOST}:/tmp/db-dump.gz /var/www/share/dev/htdocs/dev_db/.
cd /var/www/share/dev/htdocs/www
magerun db:import ../dev_db/db-dump.gz --compression=gz
magerun mothership:base:environment:import --env=vm
cl