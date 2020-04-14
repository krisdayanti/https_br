#!/bin/bash

OUT_DIR=outputs
WGET_LOG="outputs_wget.log"

[ -d $OUT_DIR ] || { mkdir -p $OUT_DIR; }

TS=`date +%Y%m%d%H%M%S`

for page in `seq 1 300`
do
    OUT_FILE="$OUT_DIR/output-$TS-$page.html"
    PAGE="https://censys.io/ipv4/_search?q=location.country%3A+Brazil+protocols%3A+(%2280%2Fhttp%22+or+%22443%2Fhttps%22)&page=$page"
    echo -n "Downloading page \"$PAGE\" ... "
    wget --output-file=$WGET_LOG --output-document=$OUT_FILE "$PAGE"
    echo " finished [check output in file $OUT_FILE]."
    L_COUNT=$(wc -l $OUT_FILE | sed 's/^\([^0-9]*\)\([0-9]\+\).*$/\2/g')
    echo $L_COUNT
    if [ $L_COUNT -lt 100 ]
    then
        echo "[ERROR] Something is wrong with the file $OUT_FILE!" 
        exit
    fi 
    sleep $((RANDOM%20))
done

