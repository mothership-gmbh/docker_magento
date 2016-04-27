#
#
# @@@@#   @@@@@    #@@@@@@   @@@@@@@@@@ @@@+    @@@  @@@@@@@@@ @@@@@       @@@@@@@  ;@@@    @@@@ ;@@@  @@@@@@@@;
# @@@@@   @@@@@   @@@@@@@@@, @@@@@@@@@@ @@@+    @@@  @@@@@@@@@ @@@@@#     @@@@@@@@# ;@@@    @@@@ ;@@@  @@@@@@@@@;
# @@@@@` #@@@@@  @@@@@@@@@@@ @@@@@@@@@@ @@@+    @@@  @@@@@@@@@ @@@@@@    ,@@@@@@@@  ;@@@    @@@@ ;@@@  @@@@@@@@@@
# @@@@@@ @@@@@@  @@@@   :@@@@   @@@@    @@@+    @@@  @@@+      @@@@      +@@@,  `+  ;@@@    @@@@ ;@@@  @@@   ;@@@
# @@@@@@ @@@@@@ +@@@     @@@@   @@@@    @@@@@@@@@@@  @@@@@@@@@ @@@@      :@@@@@@@.  ;@@@@@@@@@@@ ;@@@  @@@   @@@@
# @@@@@@@@@ @@@ @@@@     +@@@   @@@@    @@@@@@@@@@@  @@@@@@@@@ @@@@@@@#   @@@@@@@@@ ;@@@@@@@@@@@ ;@@@  @@@@@@@@@@
# @@@ @@@@@ @@@ #@@@     @@@@   @@@@    @@@@@@@@@@@  @@@@@@@@@ @@@@@@@@    @@@@@@@@ ;@@@@@@@@@@@ ;@@@  @@@@@@@@@`
# @@@ @@@@@ @@@ ,@@@'    @@@@   @@@@    @@@+    @@@  @@@+      @@@@@@@@@   `  ;@@@@;;@@@    @@@@ ;@@@  @@@@@@@#
# @@@  @@@  @@@  @@@@@;+@@@@.   @@@@    @@@+    @@@  @@@@@@@@@ @@@@ #@@@   ;@, ;@@@.;@@@    @@@@ ;@@@  @@@
# @@@  @@@  @@@  .@@@@@@@@@@    @@@@    @@@+    @@@  @@@@@@@@@ @@@@  @@@@   @@@@@@@ ;@@@    @@@@ ;@@@  @@@
# @@@  @@   @@@   `@@@@@@@+     @@@@    @@@+    @@@  @@@@@@@@@ @@@@  @@@@   ,@@@@@` ;@@@    @@@@ ;@@@  @@@
#
#

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


RUN apt-get update && apt-get install -y \

# Install mandatory tools

    vim \
    git \

# Install Apache2
    apache2 \

# Install PHP 5
    php5 \
    php5-cli \
    php5-common \
    php5-gd \
    php5-mysql \
    php5-curl \
    php5-intl \
    php5-mcrypt \
    php5-tidy \
    php5-xdebug \
    php5-imagick \
    php5-imap \
    php5-xsl \
    php5-memcache \

# Install for mysql client
    mysql-client \

# Install for mailcatcher

    build-essential \
    curl \
    wget
  #  ruby1.9.1-dev
  #  libsqlite3-dev

# Configure Apache2

# configure PHP


###############################
# PHP / XDEBUG                #
#                             #
# - Check the ip in the ini   #
###############################
RUN  rm /etc/php5/cli/conf.d/20-xdebug.ini
COPY templates/xdebug-cli.ini /etc/php5/cli/conf.d/20-xdebug.ini
COPY templates/xdebug-apache.ini /etc/php5/apache2/conf.d/20-xdebug.ini

###############################
# enable SSH                  #
###############################
RUN rm -f /etc/service/sshd/down
RUN /usr/sbin/enable_insecure_key

###############################
# z.sh                        #
###############################
RUN wget --no-check-certificate https://raw.github.com/rupa/z/master/z.sh -O /usr/local/bin/z.sh
# RUN echo '. /usr/local/bin/z.sh' >> /home/vagrant/.bashrc

###############################
# modman.phar                #
###############################
RUN git clone https://github.com/colinmollenhour/modman.git /usr/local/src/modman
RUN mv /usr/local/src/modman/modman /usr/local/bin/modman
RUN chmod +x /usr/local/bin/modman

###############################
# composer.phar               #
###############################
RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

###############################
# magerun.phar                #
###############################
RUN wget --no-check-certificate https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar -O /usr/local/bin/magerun
RUN chmod +x /usr/local/bin/magerun

###############################
# create project dir          #
###############################
RUN mkdir -p /var/www/share/dev/htdocs

###############################
# Apache 2 host configuration #
###############################
RUN mkdir -p /var/log/local.docker
RUN mkdir -p /var/www/share/dev/htdocs/www

RUN mkdir /etc/apache2/ssl
RUN cd /etc/apache2/ssl && openssl genrsa -out local_docker.key 2048
RUN cd /etc/apache2/ssl && openssl req -new -x509 -key local_docker.key -out local_docker.cert -days 3650 -subj /CN=local_docker

RUN rm /etc/apache2/sites-enabled/000-default.conf
COPY templates/project.conf /etc/apache2/sites-enabled/local-docker.conf
RUN service apache2 restart



# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/share/dev/htdocs