FROM n4zim/php-projects:symfony-fpm-advanced

MAINTAINER Nazim Lachter <nlachter@gmail.com>

# -------------------------------------------------------------------

ARG WORKDIR=/srv/symfony
ENV WORKDIR=$WORKDIR
WORKDIR $WORKDIR

COPY . .
RUN chown www-data:www-data -R .

# -------------------------------------------------------------------

# Composer install
RUN gosu www-data composer install --optimize-autoloader --prefer-dist --no-interaction --verbose

# Bower install
RUN gosu www-data if [ -f bower.json ]; then bower install --production; else echo "No bower.json"; fi

# -------------------------------------------------------------------

COPY docker-entrypoint.sh /usr/local/bin/docker-symfony-entrypoint
ENTRYPOINT [ "docker-symfony-entrypoint", "docker-php-entrypoint" ]
