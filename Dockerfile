FROM n4zim/php-projects:symfony-fpm-advanced

MAINTAINER Nazim Lachter <nlachter@gmail.com>

# -------------------------------------------------------------------

ARG WORKDIR=/srv/symfony
ENV WORKDIR=$WORKDIR
WORKDIR $WORKDIR

COPY . .
RUN chown www-data:www-data -R .

# -------------------------------------------------------------------

RUN gosu www-data composer install --optimize-autoloader --prefer-dist --no-interaction --verbose

# Bower install
#RUN gosu www-data bower install --production --allow-root

# Develoment assets (No Interaction, Full verbose) 
#RUN gosu www-data php bin/console assetic:dump -n -vvv

# Production assets (No Interaction, No debug mode, Production, Full verbose) 
#RUN gosu www-data php bin/console assetic:dump -n --no-debug -e prod -vvv

# -------------------------------------------------------------------

ENTRYPOINT [ "$WORKDIR/entrypoint.sh", "docker-php-entrypoint" ]
