#!/bin/bash

#
#	see what 'read -t' returns on timeout
#
> ~/.now.sh.tmp
read -t 1 < ~/.now.sh.tmp
timeout=$?
rm ~/.now.sh.tmp

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
                read -t 1 line; rc=$?
                if [ $rc != 0 ]; then break; fi
                echo $line
        done
        if [ $rc != $timeout ]; then break; fi
	
	#
	#	print the timestamp
	#
	if [ $# -eq 1 ]; then 
		now=`date +"$1"`
	else
		now=`date`
	fi
        echo -ne "$now\r"
done
