#!/usr/bin/env bash 

filename="$1"
query="$2"
nameshort=$(echo "$string" | sed 's/.*notes/notes/')

echo $SEPLINE
echo " File: $nameshort"
echo " Query: $query"
echo $SEPLINE

if [ -z "$query" ]; then
  head -n 10 "$filename"
else
  rg --ignore-case --pretty --context 3 "$query" "$filename"
fi

