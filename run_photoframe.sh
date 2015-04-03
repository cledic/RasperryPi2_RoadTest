#!/bin/bash

FotoPath=/tmp/images
[ -z "$1" ] || FotoPath=$1

while true;
do
  
  sudo /usr/bin/fbi -1 -noonce -T 1 -d /dev/fb0 -nocomments -noverbose -blend 1000 -t 15 -u -l $FotoPath/lista_foto.txt
  /bin/sleep 3000
  sudo /usr/bin/killall fbi
  sudo /usr/bin/killall fbi

  /usr/bin/omxplayer /media/usbkey/ISS2.mp4
  
  sudo /usr/bin/fbi -1 -noonce -T 1 -d /dev/fb0 -nocomments -noverbose -blend 1000 -t 15 -u -l $FotoPath/lista_foto.txt
  /bin/sleep 3000
  sudo /usr/bin/killall fbi
  sudo /usr/bin/killall fbi

  /usr/bin/omxplayer /media/usbkey/timelapse.mp4
  
done  
  

