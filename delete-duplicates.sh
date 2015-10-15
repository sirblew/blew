#!/bin/bash

# Find and delete duplicates recursively from a directory
# If no directory is inputted it works on the current directory
# Brendan Lewis 8/8/2012

if [ -z "$1" ] ; then
	DIR="$PWD"
else
	DIR="$1"
fi

FDUPES=`which fdupes`
if [ -z $FDUPES ] || [ ! -x $FDUPES ] ; then
	echo "Error: cannot execute \"fdupes\"!  Is it installed correctly?"
	exit 1
fi

echo -n "Are you sure you want to delete all duplicates under \"$DIR\" and its subdirectories? "
read ANSWER

if [ -z $ANSWER ] || [ $ANSWER != "y" ] ; then
	echo "Quitting!"
	exit 1
fi

# Remove the user append flag
chflags -R nouappnd "$DIR"
echo "Deleting the following duplicates in $DIR:"
$FDUPES -r -f -q "$DIR" | while read FILENAME ; do 
	if [ ! -z "$FILENAME" ] ; then
		rm -vf "$FILENAME"
	fi
done
echo
echo "Finished."
