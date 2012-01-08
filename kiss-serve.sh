#!/bin/bash

# Where to store the images?
BASE=/path/to/camdump/

# Days to keep backups for.
DAYSTOKEEP=30

CAM1=http://1.2.3.4/axis-cgi/jpg/image.cgi
CAM2=http://1.2.3.4/axis-cgi/jpg/image.cgi

case "$1" in
	monitor)
		# Camera loop
		 while [ true ]; do
			DIR=$(date +%Y/%m/%d/%H/%M)
			SEC=$(date +%S)
			mkdir -p $BASE/$DIR
			wget $CAM1 --quiet --output-document=$BASE/$DIR/$SEC\_cam1.jpg
			# wget $CAM2 --quiet --output-document=$BASE/$DIR/$SEC\_cam2.jpg
			sleep 1
		done
	;;
	
	cleanup)
		# Remove files older than 30 days
		if [ $DAYSTOKEEP -gt 1 ]
		then
			find $BASE -type f -mtime +$DAYSTOKEEP -exec rm {} \;
		else
			echo "Days to keep is less than 1 day. Exiting."
		fi
	;;
esac