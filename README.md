# KISS-surveillance: A dead-simple video surveillance tool. 

## Dependencies

* [Supervisor](http://supervisord.org/)
* [wget](http://www.gnu.org/software/wget/)

## Compatibility  

Cameras: 
Any IP-based video camera that can output static images over HTTP or HTTPS.

Operating System:
Any recent UNIX/Linux distribution should work (but only tested on Ubuntu).

## Installation

* Install the dependencies.
* Copy 'kiss-serve.sh' to the desired path.
* Edit add the content of 'supervisor/kiss-serve.conf' to your Supervisor config-file (or add it as an include). Make sure to update the 'command' line to match the path in 1). 
* Edit 'kiss-serve.sh'. If you are only monitoring one camera, update the following:
    * Set 'BASE' to where you want to store the images. Make sure 'user' from the Supervisor-config can write to this path. Also, make sure sure you enough disk space. Recording images from one camera in 640x480 every  second (DELAY=1) consumes about ~80GB for each 30 days (DAYSTOKEEP=30).
    * Make sure set 'CAM1' to match the path to where wget can fetch an image from the camera.
    * If you have multiple cameras, configure 'CAM2' and uncomment the second wget-string.
    * Configure the 'DELAY'-variable to configure the delay between recordings. By default, it is one second.
    * You may also want to modify 'DAYSTOKEEP'. This is the value the cleanup-process uses when determining what to keep and delete.
* Add a cronjob for the cleanup. The following entry should be sufficient:

    00 1	* * *	www-data	/path/to/kiss-serve.sh cleanup
* If you want to view the recorded images from a web-server, simply install and configure a web-server to do an index the folders. I prefer Nginx for this. 

That should be it to get you started. 