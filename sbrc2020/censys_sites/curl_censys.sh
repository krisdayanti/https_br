#!/bin/bash

OUT_DIR=outputs

[ -d $OUT_DIR ] || { mkdir -p $OUT_DIR; }

TS=`date +%Y%m%d%H%M%S`

for page in `seq 1 300`
do
    OUTPUT="$OUT_DIR/output-$TS-$page.html"
    PAGE="https://censys.io/ipv4/_search?q=location.country%3A+Brazil+protocols%3A+(%2280%2Fhttp%22+or+%22443%2Fhttps%22)&page=$page"
    echo -n "Downloading page \"$PAGE\" ... "
    curl --silent "$PAGE" -H 'sec-fetch-mode: cors' -H $'cookie: _ga=GA1.2.1095742992.1585074036; _gid=GA1.2.2100864646.1585074036; CENSYS-INTERNAL-JWT=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODUxMzg4NDMsImNzcmZfdG9rZW4iOiI5NThmNjRkNy1lYWFjLTQ5YzktYjI2ZC0zMmQzOWZjZDY2MDYiLCJncm91cHMiOlsic2VhcmNoIl0sInRlYW1fdXVpZCI6IjAzYWM1MjM4YjZiZDRiYWVhODY1MGJlNmYxYjJhOGI4IiwidXNlcl91dWlkIjoiMDBhNDgzMjNjZGY2NDkyNGEzMTUxY2FkNWU1ZGIyN2QiLCJ0ZWFtX25hbWUiOiJGZWRlcmFsIFVuaXZlcnNpdHkgb2YgUGFtcGEgKE1hdXJpY2lvKSIsInVzZXJfbmFtZSI6Ik1hdXJpY2lvIn0.eD81gWEksEp5y69U8Jclr-exBhQmz81uC0lQxpd3ccY; X-CSRF=958f64d7-eaac-49c9-b26d-32d39fcd6606; ajs_group_id=null; ajs_user_id=%2200a48323cdf64924a3151cad5e5db27d%22; ajs_anonymous_id=%22aa2721ee-b908-4db7-be15-7d7159ba8e2e%22; XSRF-TOKEN=eyJpdiI6IkIyejhcL3p0NzNWZkVzanJZV29MWFN3PT0iLCJ2YWx1ZSI6IlpsNnBFcmxBejdjdk1jQ0pWZHBtQUNwSnU4MGRqVjVUUXY0UHJSZGlHK1owdDZRNDAwV3hyYTJJc3B0UDBBM1wvN0RnZ3Rqd3p0S3FLNGt2S1pRSVk1QT09IiwibWFjIjoiZTJkNTczODRlOGIxNTIyODk1M2Y5ZTliNjliNjdmY2JjYzc3NmIyY2NiMWFkZGM2ZDg3NDYyMDI3ZmU2YzQyZCJ9; laravel_session=eyJpdiI6Iml3TXRrdmc4c1FvUzFrT2FvbEdtNEE9PSIsInZhbHVlIjoiallDUWgzVFVzT25sNTBDMkxZckhjRnZNYjY5N1A3N1Q2TnZlRTJzc1hPdXk3VEpvK1hCR2lrSStQdDA0ZkhtZmhMOHlFcEtNazNtSElnbHd3dVFlSnc9PSIsIm1hYyI6IjFjNTVkMzc0OGRlMzA0ZGI1YWIxZWQ3NjhkYjFjYjI3Yzc2ZmMzMjFlZmE4NjNlMTkxZDBiNjMwNTk3NjVhODEifQ%3D%3D; auth_tkt=df90cdd163486ba51bbb5898b8c881096ff9608ddfd1fd899337c09ee02fa448daf1e9b62a070ca553176e6e47d4d9a297a1795b1f504589d6c3337abaa597005e7a630abW1maW9yZW56YQ%3D%3D\u0021userid_type:b64unicode; auth_tkt=df90cdd163486ba51bbb5898b8c881096ff9608ddfd1fd899337c09ee02fa448daf1e9b62a070ca553176e6e47d4d9a297a1795b1f504589d6c3337abaa597005e7a630abW1maW9yZW56YQ%3D%3D\u0021userid_type:b64unicode; censys.io.beaker.session.id=ed1190b460a1d89c679256f0c873eb151ebb6256B6gkAU795ex4768nC9qFehNzUxvzVNmbqh3XHaYgN40bdaMvHI0Bz25yzj+QdA84lGaagB6dJy8T+ulpcVqHBaSKXRw7ND87XGRnT5ROpRIWYKG646h6lcsNu0XiHp/ZSqf8uXJQZu8ubYtMv8Fh52Qm/aHFHm8X+A+/Y1tkKgVBsgd7UIJr8eoop7JhCPL2hbKUu7gGMSvlZYGob9Xy3SOyjjBwOZ9Wlsd0Xe33N7HNBVd5k3hrU1CJNXy2rzqdkMV1+il2LDrBwaTgRjzeRDMsZDFJninkGV4=' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' -H 'accept: /' -H "referer: $PAGE" -H 'authority: censys.io' -H 'x-requested-with: XMLHttpRequest' -H 'sec-fetch-site: same-origin' --compressed > $OUTPUT
    echo " finished [check output in file $OUTPUT]."
    L_COUNT=$(wc -l $OUTPUT | sed 's/^\([^0-9]*\)\([0-9]\+\).*$/\2/g')
    echo $L_COUNT
    if [ $L_COUNT -lt 100 ]
    then
        echo "[ERROR] Something is wrong with the file $OUTPUT!" 
        exit
    fi 
    sleep $((RANDOM%30))
done

