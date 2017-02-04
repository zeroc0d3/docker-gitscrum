FROM php:7-fpm

MAINTAINER Renato Marinho <renato.marinho@s2move.com>

RUN apt-get update

RUN apt-get install -y npm \
	git \
	libcurl4-gnutls-dev \
	libmcrypt-dev  \
	libicu-dev \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install iconv \
	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install mbstring \
  && docker-php-ext-install curl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -L https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.0.0/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer

RUN chmod a+x /usr/local/bin/php-cs-fixer

RUN npm install --global gulp && ln -s "$(which nodejs)" /usr/bin/node

RUN apt-get clean

CMD ["php-fpm"]
