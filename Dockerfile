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
RUN gosu www-data [ -f bower.json ] && bower install --production ; exit 0

# Develoment assets (No Interaction, Full verbose) 
RUN gosu www-data php bin/console assetic:dump -n -vvv ; exit 0

# Production assets (No Interaction, No debug mode, Production, Full verbose) 
RUN gosu www-data php bin/console assetic:dump -n --no-debug -e prod -vvv ; exit 0

# -------------------------------------------------------------------

COPY docker-symfony-entrypoint /usr/local/bin/
ENTRYPOINT [ "docker-symfony-entrypoint", "docker-php-entrypoint" ]
