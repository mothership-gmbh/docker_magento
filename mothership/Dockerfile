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

# As PHP 7 is not supported yet, we will use another image then FROM phusion/baseimage:0.9.18
# https://github.com/phusion/baseimage-docker/issues/305
# FROM sunfoxcz/baseimage
FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN sudo add-apt-repository ppa:ondrej/php -y

RUN apt-get update && apt-get install -y --force-yes \

    # Install mandatory tools
    vim \
    git \

    # Install Apache2
    apache2 \

    # Install PHP 7
    php7.0 \
    php7.0-cli \
    php7.0-common \
    php7.0-gd \
    php7.0-mysql \
    php7.0-curl \
    php7.0-int \
    php7.0-mcrypt \
    php7.0-tidy \
    php7.0-imap \
    php7.0-xsl \
    php7.0-dev \
    php7.0-mbstring \
    php7.0-bcmath \
    php7.0-xml \
    php7.0-zip \
    php7.0-soap \
    libapache2-mod-php7.0 \
    # php7.0-memcache \

    # Install for mysql client
    mysql-client \

    # required for mailcatcher
    build-essential \
    curl \
    wget \

    # for using the dot command
    graphviz \

    # lets also include a nice terminal multiplexer
    tmux \

    # Required for some stuff
    gem \

    # Required by mailcatcher
    libsqlite3-dev

#################################
# Ruby 2                        #
#################################
RUN apt-add-repository ppa:brightbox/ruby-ng && \
sudo apt-get update && \
apt-get install ruby2.2 ruby2.2-dev -y --force-yes

#################################
# Varnish                       #
#################################
RUN curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add - && \
echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-3.0" | sudo tee -a /etc/apt/sources.list.d/varnish-cache.list && \
sudo apt-get update && sudo apt-get install -y --force-yes varnish

#################################
# Mailcatcher                   #
#################################
RUN gem install mailcatcher --conservative --no-rdoc --no-ri && \
    sed -i -e "s/.*sendmail_path =.*/sendmail_path = \/usr\/bin\/env catchmail -f mailcatcher@local\.docker/" /etc/php/7.0/apache2/php.ini && \
    sed -i -e "s/.*sendmail_path =.*/sendmail_path = \/usr\/bin\/env catchmail -f mailcatcher@local\.docker/" /etc/php/7.0/cli/php.ini


#################################
# TMUXINATOR                    #
#################################
RUN gem install tmuxinator

#################################
# JAVA OPENJDK                  #
#################################
RUN sudo add-apt-repository ppa:openjdk-r/ppa -y && \
sudo apt-get update && \
apt-get install openjdk-8-jre -y --force-yes

###############################
# Logstash                    #
###############################
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
echo "deb https://packages.elastic.co/logstash/2.3/debian stable main" | sudo tee -a /etc/apt/sources.list && \
sudo apt-get update && sudo apt-get install -y --force-yes logstash && \
ln -s /opt/logstash/bin/logstash /usr/bin/logstash

#################################
# XDEBUG - ONLY FOR PHP7        #
# Based on:                     #
# https://xdebug.org/wizard.php #
#################################
RUN cd /tmp && wget http://xdebug.org/files/xdebug-2.4.0.tgz && \
cd /tmp && tar -xvzf xdebug-2.4.0.tgz && \
cd /tmp/xdebug-2.4.0 && phpize && \
cd /tmp/xdebug-2.4.0 && ./configure && \
cd /tmp/xdebug-2.4.0 && make && \
cp /tmp/xdebug-2.4.0/modules/xdebug.so /usr/lib/php/20151012

COPY templates/xdebug-cli.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini
COPY templates/xdebug-apache.ini /etc/php/7.0/apache2/conf.d/20-xdebug.ini

###############################
# enable SSH                  #
###############################
RUN rm -f /etc/service/sshd/down && \
/usr/sbin/enable_insecure_key

###############################
# z.sh                        #
###############################
RUN wget --no-check-certificate https://raw.github.com/rupa/z/master/z.sh -O /usr/local/bin/z.sh && \
chmod +x /usr/local/bin/z.sh && \
echo '. /usr/local/bin/z.sh' >> /root/.bashrc

###############################
# modman.phar                 #
###############################
RUN git clone https://github.com/colinmollenhour/modman.git /usr/local/src/modman && \
mv /usr/local/src/modman/modman /usr/local/bin/modman && \
chmod +x /usr/local/bin/modman

###############################
# composer.phar               #
###############################
RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin && \
mv /usr/local/bin/composer.phar /usr/local/bin/composer && \
chmod +x /usr/local/bin/composer

###############################
# magerun.phar                #
###############################
RUN wget --no-check-certificate https://files.magerun.net/n98-magerun.phar -O /usr/local/bin/magerun && \
chmod +x /usr/local/bin/magerun

#################################
# NODEJS                        #
#################################
RUN sudo add-apt-repository ppa:chris-lea/node.js -y && \
sudo apt-get update && \
apt-get install nodejs -y --force-yes && \
npm i -g npm && \
npm i -g grunt-cli && \
npm i -g typings && \
npm i -g typescript

###############################
# ALIAS                       #
###############################
RUN echo "alias p='cd /var/www/share/dev/htdocs'" >> ~/.bashrc && \
echo "alias m='cd /var/www/share/dev/htdocs/www'" >> ~/.bashrc && \
echo "alias search='grep -rnw -C 100 . -e'" >> ~/.bashrc && \
echo "alias ..='cd ..'" >> ~/.bashrc && \
echo "alias ll='ls -lisah'" >> ~/.bashrc && \
echo "alias h='history'" >> ~/.bashrc && \
echo "alias hg='history |grep'" >> ~/.bashrc && \
echo "alias ports='netstat -tulanp'" >> ~/.bashrc && \
echo "export EDITOR='vim'"  >> ~/.bashrc && \
echo "alias cl='rm -rf /var/www/share/dev/htdocs/www/var/cache/* && magerun cache:clean && varnishadm "ban.url ."'" >> ~/.bashrc

###############################
# Apache 2 host configuration #
###############################
RUN mkdir -p /var/www/share/dev/htdocs && \
    mkdir -p /var/log/local.docker && \
    mkdir -p /var/www/share/dev/htdocs/www && \
    mkdir /etc/apache2/ssl && \
    mkdir -p /etc/my_init.d

RUN cd /etc/apache2/ssl && openssl genrsa -out local_docker.key 2048
RUN cd /etc/apache2/ssl && openssl req -new -x509 -key local_docker.key -out local_docker.cert -days 3650 -subj /CN=local_docker

RUN rm /etc/apache2/sites-enabled/000-default.conf
COPY templates/project.conf /etc/apache2/sites-enabled/local-docker.conf
RUN a2enmod ssl
RUN a2enmod rewrite

ADD apache.sh /etc/my_init.d/apache.sh
ADD mailcatcher.sh /etc/my_init.d/mailcatcher.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/share/dev/htdocs