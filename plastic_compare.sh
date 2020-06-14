#!/bin/bash
if [ $# -eq 1 ] ; then
	diff --minimal --color=always -C 0 --from-file $1/*.plastic
else
	echo "USAGE: $0 <directory>"
fi
