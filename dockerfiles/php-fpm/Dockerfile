FROM php:7.0.14-fpm

ENV TERM=xterm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libxslt-dev \
        libmcrypt-dev \
        libpng12-dev \
        git \
        wget \
        vim \
        graphviz \
        telnet \
        mysql-client \
        ssmtp \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo_mysql xsl zip bcmath \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install redis xdebug && docker-php-ext-enable redis xdebug


###############################
# z.sh                        #
###############################
RUN wget --no-check-certificate https://raw.github.com/rupa/z/master/z.sh -O /usr/local/bin/z.sh && \
chmod +x /usr/local/bin/z.sh && \
echo '. /usr/local/bin/z.sh' >> /root/.bashrc

###############################
# modman.phar                 #
###############################
RUN curl -sL https://raw.githubusercontent.com/colinmollenhour/modman/master/modman -o /usr/local/bin/modman \
    && chmod +x /usr/local/bin/modman

###############################
# ceodecept.phar                #
###############################
RUN curl -sL http://codeception.com/codecept.phar -o /usr/local/bin/codecept \
    && chmod +x /usr/local/bin/codecept

# magerun.phar                #
###############################
RUN curl -sL https://files.magerun.net/n98-magerun.phar -o /usr/local/bin/magerun \
    && chmod +x /usr/local/bin/magerun

###############################
# composer.phar               #
###############################
RUN curl -sL https://getcomposer.org/download/1.2.0/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Speed up install composer libraries
RUN composer global require "hirak/prestissimo:^0.3"




ADD ./conf.d/mothership.ini /usr/local/etc/php/conf.d/mothership.ini
ADD ./conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
ADD ./conf.d/sendmail.ini /usr/local/etc/php/conf.d/sendmail.ini
ADD ./etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf


RUN cd /tmp && \
    curl -sL https://github.com/alanxz/rabbitmq-c/releases/download/v0.8.0/rabbitmq-c-0.8.0.tar.gz -o rabbitmq-c-0.8.0.tar.gz  && \
    tar xzf rabbitmq* && cd rabbitmq* && ./configure && make && make install

RUN pecl install amqp && docker-php-ext-enable amqp

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/share/dev/