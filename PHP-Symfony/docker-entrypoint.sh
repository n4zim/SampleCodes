#!/bin/sh

if [ -z "$WORKDIR" ]
  then
    
    echo "NO $WORKDIR ENV VAR !"
  
  else
	
	cd $WORKDIR
	
	if [[ ! -d "var" ]]; then gosu www-data mkdir var; fi
	
	if [[ -d "var/cache" ]]; then rm -rf var/cache/*; fi

    echo "# Develoment assets (No Interaction, Full verbose)"
	gosu www-data php bin/console assetic:dump -n -vvv

    echo "# Production assets (No Interaction, No debug mode, Production, Full verbose)"
	gosu www-data php bin/console assetic:dump -n --no-debug -e prod -vvv

    echo "# Parameters and Bootsrap"
	gosu www-data composer run-script symfony-part1 --no-interaction --verbose

    echo "# Database update"
	gosu www-data php bin/console doctrine:schema:update --force

    echo "# Cache, assets, requirements, deploying"
	gosu www-data composer run-script symfony-part2 --no-interaction --verbose

fi

exec "$@"
