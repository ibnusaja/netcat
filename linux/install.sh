#!/bin/bash

# jangan beri nama file ini dengan nc atau netcat agar saat pgrep terhindar dari doble pid
if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

URL="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/nutcut.sh"
md5URL="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/md5fornutcut"
md5=$(curl -s $md5URL) #md5 file

URL2="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/runnutcut.sh"
md5_2URL="https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/md5forrunnutcut"
md5_2=$(curl -s $md5_2URL)


if [[ "$(id -u)" != "0" ]];then
 echo "    GAGAL !!!,kamu harus dalam mode root"
 exit 0
fi

echo;echo "instalasi progress ...";echo

if [ -f "/bin/nutcut" ]
then
   echo "sudah terinstall, akan di cek apakah verifed"
   if [[ $(md5sum /bin/nutcut | awk '{ print $1 }') == "$md5" ]]; then
      echo "okee, terverifikasi sesuai !!"
      if [ $(stat -c %a /bin/nutcut) -eq 755 ]; then
         echo "permission juga oke,"
      else
         chmod 755 /bin/nutcut
         echo;echo "kesalahan permission"
         echo "ulangi instalasi ini !!"
      fi
   else
      rm -rf /bin/nutcut
      echo "gagal terverifikasi, paket yang terinstall tdk sesuai"
      echo "segera ulangi instalasi ini !!"
      exit 0
   fi
else
   echo "file kosong, instalasi akan dilaksanakan"
   rm -rf /bin/nutcut && sleep 1
   curl -s $URL > /bin/nutcut
   chmod 755 /bin/nutcut
fi


if [ -f "/bin/nutcut" ]
then
    # File exists, do something here
    echo "step 1 berhasil"
    sleep 1
else
    # File does not exist, display message
    echo "instalasi gagal step 1, pastikan koneksi internet bagus"
    exit 0
fi

if [[ $(md5sum /bin/nutcut | awk '{ print $1 }') == "$md5" ]]; then
    echo "step 2 berhasil"
else
    echo "instalasi gagal step 2, pastikan koneksi internet bagus"
    exit 0
fi

if [ $(stat -c %a /bin/nutcut) -eq 755 ]; then
  echo "step 3 berhasil"
else
    echo "instalasi gagal step 3, ulangi instalasi "
    chmod 755 /bin/nutcut
    exit 0
fi


# file 2

if [ -f "/etc/init.d/runnutcut" ];then
   echo "file ada akan di cek dibawah"
else
   curl -s $URL2 > /etc/init.d/runnutcut
   chmod 755 /etc/init.d/runnutcut
fi


if [ -f "/etc/init.d/runnutcut" ];then
   echo "step 4 berhasil;, file ada"
   if [ $(stat -c %a /etc/init.d/runnutcut) -eq 755 ];then
      echo "step 5 berhasil, permission oke"
      if [[ $(md5sum /etc/init.d/runnutcut | awk '{ print $1 }') == "$md5_2" ]]; then
         echo "step 6 berhasil, verified oke"
      else
         curl -s $URL2 > /etc/init.d/runnutcut
         echo "gagal step 6 pada file 2"
         echo "ulangi instalasi !!"
         exit 0
      fi
   else
      chmod 755 /etc/init.d/runnutcut
      echo "gagal step 5 pada file 2"
      echo "ulangi instalasi !!"
      exit 0
   fi
else
   curl -s $URL2 > /etc/init.d/runnutcut
   echo "gagal step 4 pada file 2"
   echo "ulangi instalasi !!"
   exit 0
fi

# tahap terakhior cek file rc.local

if [ -f "/etc/rc.local" ];then
   chmod 755 /etc/rc.local
   echo "start up terpasang, memverifikasi start up"
   var=$(cat /etc/rc.local | grep /etc/init.d/runnutcut)
   if [ -f "$var" ] && [ $(stat -c %a /bin/nutcut) -eq 755 ] ;then
      echo "startup terpasang, dan permission oke"
   else
      sed -i "/exit 0/i /etc/init.d/runnutcut" /etc/rc.local
      chmod 755 /etc/rc.local
      echo "startup belum terpasang, mengulangii instalasi"
   fi
else
   echo "startup gak ada. membuat startup ..."

   echo '#!/bin/bash
/etc/init.d/runnutcut
exit 0' > /etc/rc.local

   chmod 755 /etc/rc.local
   if [ -f "/etc/rc.local" ];then
      echo "start up terpasang, memverifikasi start up"
      var=$(cat /etc/rc.local | grep /etc/init.d/runnutcut)
      if [ -f "$var" ] && [ $(stat -c %a /bin/nutcut) -eq 755 ] ;then
         echo "startup terpasang, dan permission oke"
      else
         sed -i "/exit 0/i /etc/init.d/runnutcut" /etc/rc.local
         chmod 755 /etc/rc.local
         echo "startup belum terpasang, ulangii instalasi"
         exit 0
      fi
   fi
fi


var=$(cat /etc/rc.local | grep /etc/init.d/runnutcut)
if [ -f "/etc/rc.local" ] && [ -f "$var" ];
then
   echo "tahap terakahir selesai"
else
   echo "tahap terakhir gagal"
   echo "ulangi instalasi !!"
   exit 0
fi

cekid=$(pgrep -f nutcut)
if [ "$cekid" != "" ];then
   echo "service telah dijalankan di pid $cekid"
else
   echo "service belum jalan, akan dijalankan"
   /etc/init.d/runnutcut
   if [ "$(pgrep -f nutcut)" != "" ];then
       echo "service berhasil dijalankan di pid $(pgrep -f nutcut)"
   else
       echo "ada error, coba ulangi instalasi"
   fi
fi

echo
echo "DONE sempurna"
