FROM n4zim/php-projects:symfony-fpm-advanced

MAINTAINER Nazim Lachter <nlachter@gmail.com>

# -------------------------------------------------------------------

ARG DATABASE_HOST
ENV DATABASE_HOST=${DATABASE_HOST}
ARG DATABASE_PORT
ENV DATABASE_PORT=${DATABASE_PORT}
ARG DATABASE_NAME
ENV DATABASE_NAME=${DATABASE_NAME}
ARG DATABASE_USER
ENV DATABASE_USER=${DATABASE_USER}
ARG DATABASE_PASSWORD
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ARG SECRET
ENV SECRET=${SECRET}

# -------------------------------------------------------------------

ARG WORKDIR
WORKDIR $WORKDIR
COPY . .
RUN chown www-data:www-data -R .

# -------------------------------------------------------------------

RUN gosu www-data composer install --optimize-autoloader --prefer-dist --no-interaction --verbose

# Bower install
#RUN gosu www-data bower install --production --allow-root

# Develoment assets (No Interaction, Full verbose) 
#RUN gosu www-data php bin/console assetic:dump -n -vvv \
#	  > /var/log/zei-assets-dev.log 

# Production assets (No Interaction, No debug mode, Production, Full verbose) 
#RUN gosu www-data php bin/console assetic:dump -n --no-debug -e prod -vvv \
#	  > /var/log/zei-assets-prod.log 
 
# Database Update (Force, No Interation, No Debug, Full verbose) 
#RUN gosu www-data php bin/console doctrine:schema:update -f -n --no-debug -vvv \
#	  > /var/log/zei-database.log 
 
# Cache clear (No Interaction, No debug mode, No cache warm up, Production, Full verbose) 
#RUN gosu www-data php bin/console cache:clear -n --no-debug --no-warmup -e prod -vvv \
#	  > /var/log/zei-cache.log 
