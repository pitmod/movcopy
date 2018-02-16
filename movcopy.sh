#!/bin/bash
###
# movcopy.sh
# v1.0
# Author: Piotr Modlinger
# Description: Script to find copy and deduplicate movies from /home/pitmod/Wideo to nasbox:/mediasrv/Zdjecia

### Declarations
DST_SRV=nasbox
SRC="/home/pitmod"
DST="/mediasrv/Filmy/"
WORKDIR="/home/pitmod/Scripts/movcopy"

find $SRC -type f -name "*.mp4" -o -name "*.avi" -o -name "*.rmvb" -o -name "*.mkv" | grep -v -i trash | tee $WORKDIR/wideo.rsync

read -p "Are you sure you want to move these files to $DST_SRV:$DST and remove from $SRC ? " -n 1 -r
echo "If you want to omit some files please remove them from $WORKDIR/wideo.rsync and enter Y."
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Copying files..."
	rsync -avhPe ssh --remove-source-files `cat $WORKDIR/wideo.rsync` $DST_SRV:$DST && echo "Done"
fi
