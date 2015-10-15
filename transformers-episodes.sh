#!/bin/bash

#DISCS=S1_D1 S1_D2 S2_D1 S2_D2 S2_D3 S2_D4 S2_D5 S2_D6 S2_D7 S3_4_D1 S3_4_D2 S3_4_D3 S3_4_D4
DISCS="S3_4_D1 S3_4_D2 S3_4_D3 S3_4_D4"

cd /Users/blew/Movies/Transformers

i=1
while read LINE ; do
	NUM[$i]=`echo $LINE | awk '{print $1}'`
	NAME[$i]=`echo $LINE | cut -d " " -f 2-`
#	echo ${NUM[$i]}
#	echo ${NAME[$i]}
	let i=i+1
done < episodes.txt

#disc1
for DISC in $DISCS ; do
	echo "Which number episode to start at for disc $DISC? "
	read STARTNUM
	SERIES=`echo $DISC | sed -e 's/^S//g' -e 's/_D.*$//g'`
#	for FILENAME in `ls TRANSFORMERS_${DISC}*.mp4 | sed -e 's/^.*D/D/g' | sort -n -t "_" -k 2` ; do
	if [ $SERIES == "3_4" ] ; then
		KEY=5
	else
		KEY=4
	fi
	for OLDNAME in `ls TRANSFORMERS_${DISC}*.mp4 | sort -n -t "_" -k $KEY` ; do
	EPISODE=${NUM[$STARTNUM]}
		NEWNAME=`grep -e "^$EPISODE\W" episodes.txt | cut -d " " -f 3-`

		if [ ! -s "$OLDNAME.jpg" ] ; then
			echo "Grabbing title frame for $OLDNAME"
			ffmpeg -i "$OLDNAME" -ss 00:00:37 -vframes 1 "$OLDNAME.jpg" >/dev/null 2>&1
		fi
		open "$OLDNAME.jpg" >/dev/null 2>&1
		NEWFILE="The Transformers - S${SERIES}E${EPISODE} - $NEWNAME.mp4"
		echo "This episode: $NEWNAME"
		echo "Enter confirm or ctrl-c to abort: mv -i \"$OLDNAME\" \"$NEWFILE\""
		read INPUT
		if [ ! -z $INPUT ] ; then
			NEWFILE="$INPUT"
		else
			NEWFILE="The Transformers - S${SERIES}E${EPISODE} - $NEWNAME.mp4"
		fi
		mv -i "$OLDNAME" "$NEWFILE"
		let STARTNUM=STARTNUM+1
	done
done
