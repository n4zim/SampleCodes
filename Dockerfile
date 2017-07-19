FROM php:7.1-fpm

MAINTAINER Nazim Lachter <nlachter@gmail.com>

COPY . /var/www/
WORKDIR /var/www/

CMD [ "php", "./index.php" ]
