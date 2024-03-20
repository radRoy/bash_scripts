#!/bin/bash

string="/home/dwalth/123.txt"
if [ $1 ]; then
	query=$1
else
	query="123"
fi

# if [[ $s == *$q* ]]; then  # works
# if [[ $s =~ $q ]]; then  # works

if [[ $string == *$query* ]]; then
	echo "True"
else
	echo "False"
fi

