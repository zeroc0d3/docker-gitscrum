FROM php:7-fpm

RUN apt-get update && apt-get install -y \
	npm \
	wget \
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

RUN wget -O /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
RUN wget -O /usr/local/bin/phpcbf https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
RUN chmod a+x /usr/local/bin/phpcs /usr/local/bin/phpcs
RUN phpcs --config-set default_standard PSR2

RUN npm install --global gulp && ln -s "$(which nodejs)" /usr/bin/node

RUN apt-get autoremove -y wget && apt-get clean

CMD ["php-fpm"]
