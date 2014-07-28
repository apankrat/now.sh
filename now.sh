#!/bin/bash

#
#  See what 'read -t' returns on timeout.
#
#  For that - read from stdout. Alternatively, it could read
#  from /dev/zero, but it's not available under Cygwin and
#  in other non-*nix environments.
#
#  Also note, that while bash manual states that the return
#  code on a timeout is greater than 128, it doesn't hold
#  true with a number of bash implementations, most notably
#  including GNU bash that returns 1 instead.
#

cleanup(){
        # make sure to put a newline at the end of output, that
        # way our prompt won't get written on the last timestamp
        echo
}
trap cleanup SIGINT

read -t 1 <&1
timeout=$?

did_timeout=0
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
                if [ $did_timeout != 0 ]; then
                        # because otherwise we overwrite the time output, and that looks bad
                        echo
                        did_timeout=0
                fi
                echo "$line"
        done
	#
	#	exit status is greater than 128 if the timeout is exceeded
	#
	if [ $rc != $timeout ]; then break; fi

	#
	#	print the timestamp
	#
        now=`date ${1:++"$1"}`
        echo -ne "$now\r" >&2
        did_timeout=1
done
