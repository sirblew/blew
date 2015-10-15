#!/bin/bash

# This script:
# Removes .DS_Store files from all directories
# Removes empty subdirectories

if [ -z "$1" ] ; then
	echo "Error: No directory given!  Usage:"
	echo "$0 directory"
	exit 1
else
	DIR="$1"
fi

if [ ! -d "$DIR" ] ; then
	echo "Error: Directory $DIR does not exist or is not a directory!"
	exit 1
fi

# Remove the user append flag
chflags -R nouappnd "$DIR"
# Delete .DS_Store files
find "$DIR" -name .DS_Store -exec rm -f {} \;
# Delete empty directories
find "$DIR" -empty -exec ls -d {} -exec rmdir {} \;
