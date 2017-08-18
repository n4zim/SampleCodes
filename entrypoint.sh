#!/bin/sh

if [ -z "$WORKDIR" ]
  then
    
    echo "NO $WORKDIR ENV VAR !"
  
  else
	
	cd $WORKDIR
	
	if [[ ! -d "var" ]]; then gosu www-data mkdir var; fi
	
	if [[ -d "var/cache" ]]; then rm -rf var/cache/*; fi
	
	gosu www-data composer run-script symfony-part1 --no-interaction --verbose
	
	gosu www-data php bin/console doctrine:schema:update --force
	
	gosu www-data composer run-script symfony-part2 --no-interaction --verbose

fi

exec "$@"
