#!/usr/bin/env bash


set -a
source .env

rm -rf ${PROJECT_VOlUME}/htdocs/.modman
rm -rf ${PROJECT_VOlUME}/htdocs/www
rm -rf ${PROJECT_VOlUME}/htdocs/vendor

rsync -rv --exclude=.git ${PROJECT_SOURCE}/.modman/ ${PROJECT_VOlUME}/htdocs/.modman
rsync -rv --exclude=.git ${PROJECT_SOURCE}/www/ /${PROJECT_VOlUME}/htdocs/www
rsync -rv --exclude=.git ${PROJECT_SOURCE}/vendor/ ${PROJECT_VOlUME}/htdocs/vendor
