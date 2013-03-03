#!/bin/bash

#
#	See what 'read -t' returns on timeout.
#
#	For that - read from stdout. Alternatively, it could read 
#	from /dev/zero, but it's not available under Cygwin and 
#	in other non-*nix environments
#
read -t 1 <&1
timeout=$?

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
        echo -ne "$now\r" >&2
done
