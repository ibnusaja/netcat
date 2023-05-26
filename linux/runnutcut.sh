#!/bin/bash
# jangan beri nama file ini dengan nc atau netcat atau awalan dari 2 hal tadi agar saat pgrep terhindar dari doble pid
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

# while [ "$(who -r | awk '{print $2}')" != "5" ]; do sleep 1; done


# nohup /bin/nc2 > /home/kali/Desktop/logNC.txt 2> /home/kali/Desktop/logNC.txt &
nohup /bin/nutcut > /dev/null 2> /dev/null &
exit 0
