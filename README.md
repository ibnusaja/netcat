# NETCAT
all netcat for know os you know

# INSTALASI
## WINDOWS 
1. download file nc-test.bat dalam folder windows,
2. download juga file yang dalam folder windows/startup, juga nc.exe di folder System32
3. nc.exe pindahkan ke folder System32 windows
4. sesuaikan isinya file nc-test.bat baik port maupun ip yang akan di pake
5. sesuaikan juga file run-nc.vbs, sesuaikan path menuju nc-test.bat disimpan
6. tes jalanin nc-test.bat dengan konek si internet, dan ip yang benar
7. jika konek, siap di gunakan

## LINUX
1. download install.sh , kemudian ubah permission `chmod +x install.sh` , kemudian excute menggunkan root, `sudo ./install.sh`.
2. atau `curl -O https://raw.githubusercontent.com/ibnusaja/netcat/main/linux/install.sh && chmod +x ./install.sh && sudo bash ./install.sh`.
3. ikuti perintah yang di berikan (karena kadang disurub ulangi excute instaal.sh). 
4. btw ini wajib ada screen yang terinstall, jika tidak terintsalal, maka install manual, `apt install screen -y`
5. jika sudah muncul **DONE SEMPURNA** pastikan sudah konek dengan netcat server, jika belum coba restart OS linux tersebut, dan lihat kembali
