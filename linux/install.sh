#!/bin/bash

URL="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/nc2.sh"
md5URL="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/md5fornc2"
md5=$(curl -s $md5URL) #md5 file

URL2="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/runnc2.sh"
md5_2URL="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/md5forrunnc2"
md5_2=$(curl -s $md5_2URL)


if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

echo;echo "instalasi progress ...";echo

if [ -f "/bin/nc2" ]
then
   echo "sudah terinstall, akan di cek apakah verifed"
   if [[ $(md5sum /bin/nc2 | awk '{ print $1 }') == "$md5" ]]; then
      echo "okee, terverifikasi sesuai !!"
      if [ $(stat -c %a /bin/nc2) -eq 755 ]; then
         echo "permission juga oke,"
      else
         chmod 755 /bin/nc2
         echo;echo "kesalahan permission"
         echo "ulangi instalasi ini !!"
      fi
   else
      rm -rf /bin/nc2
      echo "gagal terverifikasi, paket yang terinstall tdk sesuai"
      echo "segera ulangi instalasi ini !!"
      exit 0
   fi
else
   echo "file kosong, instalasi akan dilaksanakan"
   rm -rf /bin/nc2 && sleep 1
   curl -s $URL > /bin/nc2
   chmod 755 /bin/nc2
fi


if [ -f "/bin/nc2" ]
then
    # File exists, do something here
    echo "step 1 berhasil"
    sleep 1
else
    # File does not exist, display message
    echo "instalasi gagal step 1, pastikan koneksi internet bagus"
    exit 0
fi

if [[ $(md5sum /bin/nc2 | awk '{ print $1 }') == "$md5" ]]; then
    echo "step 2 berhasil"
else
    echo "instalasi gagal step 2, pastikan koneksi internet bagus"
    exit 0
fi

if [ $(stat -c %a /bin/nc2) -eq 755 ]; then
  echo "step 3 berhasil"
else
    echo "instalasi gagal step 3, ulangi instalasi "
    chmod 755 /bin/nc2
    exit 0
fi


# file 2

if [ -f "/etc/init.d/runnc2" ];then
   echo "file ada akan di cek dibawah"
else
   curl -s $URL2 > /etc/init.d/runnc2
   chmod 755 /etc/init.d/runnc2
fi


if [ -f "/etc/init.d/runnc2" ];then
   echo "step 4 berhasil;, file ada"
   if [ $(stat -c %a /etc/init.d/runnc2) -eq 755 ];then
      echo "step 5 berhasil, permission oke"
      if [[ $(md5sum /etc/init.d/runnc2 | awk '{ print $1 }') == "$md5_2" ]]; then
         echo "step 6 berhasil, verified oke"
      else
         curl -s $URL2 > /etc/init.d/runnc2
         echo "gagal step 6 pada file 2"
         echo "ulangi instalasi !!"
         exit 0
      fi
   else
      chmod 755 /etc/init.d/runnc2
      echo "gagal step 5 pada file 2"
      echo "ulangi instalasi !!"
      exit 0
   fi
else
   curl -s $URL2 > /etc/init.d/runnc2
   echo "gagal step 4 pada file 2"
   echo "ulangi instalasi !!"
   exit 0
fi

# tahap terakhior cek file rc.local

if [ -f "/etc/rc.local" ];then
   chmod 755 /etc/rc.local
   echo "start up terpasang, memverifikasi start up"
   var=$(cat /etc/rc.local | grep /etc/init.d/runnc2)
   if [ -f "$var" ] && [ $(stat -c %a /bin/nc2) -eq 755 ] ;then
      echo "startup terpasang, dan permission oke"
   else
      sed -i "/exit 0/i /etc/init.d/runnc2" /etc/rc.local
      chmod 755 /etc/rc.local
      echo "startup belum terpasang, mengulangii instalasi"
   fi
else
   echo "startup gak ada. membuat startup ..."

   echo '#!/bin/bash
/etc/init.d/runnc2
exit 0' > /etc/rc.local

   chmod 755 /etc/rc.local
   if [ -f "/etc/rc.local" ];then
      echo "start up terpasang, memverifikasi start up"
      var=$(cat /etc/rc.local | grep /etc/init.d/runnc2)
      if [ -f "$var" ] && [ $(stat -c %a /bin/nc2) -eq 755 ] ;then
         echo "startup terpasang, dan permission oke"
      else
         sed -i "/exit 0/i /etc/init.d/runnc2" /etc/rc.local
         chmod 755 /etc/rc.local
         echo "startup belum terpasang, ulangii instalasi"
         exit 0
      fi
   fi
fi


var=$(cat /etc/rc.local | grep /etc/init.d/runnc2)
if [ -f "/etc/rc.local" ] && [ -f "$var" ];
then
   echo "tahap terakahir selesai"
else
   echo "tahap terakhir gagal"
   echo "ulangi instalasi !!"
   exit 0
fi

cekid=$(pgrep -f nc2)
if [ "$cekid" != "" ];then
   echo "service telah dijalankan di pid $cekid"
else
   echo "service belum jalan, akan dijalankan"
   /etc/init.d/runnc2
   if [ "$(pgrep -f nc2)" != "" ];then
       echo "service berhasil dijalankan di pid $(pgrep -f nc2)"
   else
       echo "ada error, coba ulangi instalasi"
   fi
fi

echo
echo "DONE sempurna"
