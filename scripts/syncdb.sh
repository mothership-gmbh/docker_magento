#!/usr/bin/env bash

set -a
source .env

# development @log catalog_product_entity catalog_product_entity_*
# magerun db:dump --strip="@development @log catalog_product* catalog_category_product core_url_rewrite cataloginventory_stock_status* cataloginventory_stock_item" --add-routines --compression=gz /tmp/db-dump.gz

# ssh web-user@${REMOTE_HOST} "cd ${REMOTE_HOST_PATH}; magerun db:dump /tmp/db-dump.gz --compression=gz --add-routines --strip=\"@stripped\""
scp web-user@${REMOTE_HOST}:/tmp/db-dump.gz ./container_configuration/db/dump/db-dump.sql.gz