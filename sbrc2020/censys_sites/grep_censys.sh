#!/bin/bash

[ $1 ] && [ -f $1 ] || { echo "Usage: $0 <file1.html> <file2.html> ... <fileN.html>"; exit; }

for page in $*
do
    grep "/ipv4/" "$page" | cut -d">" -f2
done

