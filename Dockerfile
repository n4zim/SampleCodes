FROM php:7.1-fpm-alpine

MAINTAINER Nazim Lachter <nlachter@gmail.com>

# Adding packages "dockerize" and "gosu"
RUN apk add dockerize gosu --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

# Adding new user "symfony"
RUN addgroup -g 500 symfony \
 && adduser -u 500 -D -G symfony -h /home/symfony -s /bin/sh symfony \
 && mkdir /srv/symfony \
 && chown symfony:symfony /srv/symfony

# Adding build dependencies
RUN apk add --no-cache --virtual .build-dependencies curl curl-dev icu-dev coreutils

# Adding PHP extensions
RUN docker-php-ext-install -j$(nproc) curl iconv intl json mbstring opcache pdo_mysql pdo_sqlite zip

# Adding Composer CLI
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

# Adding Symfony CLI
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
 && chmod a+x /usr/local/bin/symfony

# Cleaning
RUN apk del .build-dependencies

# Entrypoint
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /usr/local/bin/entrypoint.sh

# Home permissions
RUN chown symfony:symfony -R /home/symfony

WORKDIR /srv/symfony
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/sh"]
