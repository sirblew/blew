#!/bin/bash

# Grab a screenshot of the episode title for Transformers
# Brendan Lewis 27/08/2015

mkdir images
for i in *.mp4 ; do
        ffmpeg -i "$i" -ss 00:00:37 -vframes 1 "images/$i.jpg"
#       ls "$i"
#	echo "Press enter to continue"
#	read lalala
done
