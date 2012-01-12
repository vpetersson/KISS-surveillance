#!/bin/bash

# Where should we store the images? 
# !!!! This must be a dedicated folder, otherwise the cleanup process will wipe content. !!!!!
BASE=/path/to/camdump/

# Interval between recordings (in seconds)
DELAY=1

# Days to keep the recording archive for.
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
			sleep $DELAY
		done
	;;
	
	cleanup)
		# Remove files older than DAYSTOKEEP
		if [ $DAYSTOKEEP -gt 1 ]
		then
			find $BASE -type f -mtime +$DAYSTOKEEP -exec rm {} \;
			find $BASE -type d -empty -depth -exec rmdir {} \;
		else
			echo "Days to keep is less than 1 day. Exiting."
		fi
	;;
esac