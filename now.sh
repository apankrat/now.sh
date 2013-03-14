#!/bin/bash

if [ ${BASH_VERSINFO[0]} -ge 4 ]; then
	#
	# The return value of the read command is 128+SIGALRM
	# if the timeout is exceeded.
	#
	timeout_rc=128
	timeout_exp=-le
else
	#
	#  See what 'read -t' returns on timeout.
	#
	#  For that - read from stdout. Alternatively, it could read
	#  from /dev/zero, but it's not available under Cygwin and
	#  in other non-*nix environments.
	#
	read -t 1 <&1
	timeout_rc=$?
	timeout_exp=-ne
fi

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
	if [ $rc $timeout_exp $timeout_rc ]; then break; fi

	#
	#	print the timestamp
	#
        now=`date ${1:++"$1"}`
        echo -ne "$now\r" >&2
done
