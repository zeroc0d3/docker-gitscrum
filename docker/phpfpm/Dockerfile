ARG PHP_VERSION=7.1.14
FROM php:${PHP_VERSION}-fpm

MAINTAINER "Renato Marinho <renato.marinho@s2move.com>"

ENV XDEBUG_VERSION 2.6.0

RUN apt-get update

RUN apt-get install -y npm \
    git \
    libcurl4-gnutls-dev \
    libmcrypt-dev  \
    libicu-dev \
    zip \
    unzip \
    zlib1g-dev \
    libicu-dev g++ \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install iconv \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install curl \
    && docker-php-ext-install zip

# Install nodejs
RUN apt-get install -y python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global gulp gulp-cli

# Install xdebug
COPY ./docker-php-pecl-install /usr/local/bin/
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install php-cs-fixer
RUN curl -L https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.0.0/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
RUN chmod a+x /usr/local/bin/php-cs-fixer

RUN mkdir -p /var/log/php-fpm \
    && touch /var/log/php-fpm/fpm-error.log \
    && chmod 777 /var/log/php-fpm/fpm-error.log

RUN apt-get clean

EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]