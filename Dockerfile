FROM php:7.1-fpm-alpine

MAINTAINER Nazim Lachter <nlachter@gmail.com>

# Adding "dockerize" and "gosu"
RUN apk add dockerize gosu --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

# Adding new user "symfony"
RUN addgroup -g 500 symfony \
 && adduser -u 500 -D -G symfony -h /home/symfony -s /bin/sh symfony \
 && mkdir /srv/symfony \
 && chown symfony:symfony /srv/symfony

# Update repository
RUN set -xe apk update apk upgrade

# Git (for Composer)
RUN apk add --no-cache git

# Fixed Intl version
RUN apk add --no-cache libintl icu icu-dev \
 && docker-php-ext-install intl \
 && apk del icu-dev \
 && docker-php-ext-install opcache

# PDO & MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Adding Composer CLI
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

# Adding Symfony CLI
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
 && chmod a+x /usr/local/bin/symfony

# Cleaning
RUN rm -rf /tmp/* /var/cache/apk/*

# Entrypoint
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /usr/local/bin/entrypoint.sh

# Home permissions
RUN chown symfony:symfony -R /home/symfony

WORKDIR /srv/symfony
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/sh"]
