#!/bin/bash

lf='
'

test_input_output()
{
  local name="$1"; shift
  local expected="$1"; shift
  local got=`echo "$expected" |bash ./now.sh`
  if [ "$got" = "$expected" ]; then
    echo "OK: I/O: $name: \"$expected\""
  else
    echo "NG: I/O: $name: \"$expected\": Got: \"$got\""
  fi
}

test_input_output 'Glob pattern'        '*'
test_input_output 'Spaces'              'foo   bar'
test_input_output 'LF at EOL'           'foo\'"$lf"' barbar'

