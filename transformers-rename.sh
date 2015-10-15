#!/bin/bash

# Manually rename transformers episodes based on the episode image

cd /Users/blew/Movies/Transformers
open episodes.txt
for OLDNAME in `ls TRANSFORMERS_S*.mp4 | sort -n +3.4` ; do
	if [ ! -s "$OLDNAME.jpg" ] ; then
		echo "Grabbing title frame for $OLDNAME"
		ffmpeg -i "$OLDNAME" -ss 00:00:37 -vframes 1 "$OLDNAME.jpg"
	fi
	open "$OLDNAME.jpg" >/dev/null 2>&1
	echo
	echo "Enter new episode name without the extension:"
	read $INPUT
	NEWNAME=`echo $INPUT | awk '{print $2,$3,$1,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14}' | sed -e's/\:/ \-/g'`
	echo $NEWNAME
	mv -i "$OLDNAME" "$NEWNAME"
	echo "$OLDNAME renamed to $NEWNAME"
	echo
done
