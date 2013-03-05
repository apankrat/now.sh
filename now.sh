#!/bin/bash

#
#	loop forever
#
while true
do
	#
	#	relay stdin to stdout
	#
        while true
        do
                IFS= read -r -t 1 line; rc=$?
                if [ $rc != 0 ]; then break; fi
                echo "$line"
        done
	#
	#	exit status is greater than 128 if the timeout is exceeded
	#
	if [ $rc -le 128 ]; then break; fi

	#
	#	print the timestamp
	#
	if [ $# -eq 1 ]; then
		now=`date +"$1"`
	else
		now=`date`
	fi
        echo -ne "$now\r" >&2
done
