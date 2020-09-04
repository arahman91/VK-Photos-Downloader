#!/bin/bash

echo "VK Photos Downloader"

if [ "$1" = "" ]; then
	echo "Usage: `basename $0` <-u Album URL> | <-o Folder name>"
	exit 1
fi

# Make a directory for pictures.

if [ "$1" = "-u" ]; then
	dir_name=$(wget -q -O- $2 | grep '<title>' | cut -d '<' -f 2 | cut -d '>' -f 2 | sed 's/....$//')
elif ["$1" = "-o" ]; then
	dir_name=$2
else
	echo "Usage: `basename $0` <-u Album URL> | <-o Folder name>"
	exit 1
fi
mkdir "$dir_name"

ls | grep 'photo' | xargs strings | grep "w_src" | grep -oE 'z[^,]+,' | grep "http" | grep ".jpg" | cut -d '"' -f 3 | sed 's/\\//g' > log1.txt
awk '!a[$0]++' log1.txt > log2.txt

wget -N -i log2.txt -P "$dir_name"