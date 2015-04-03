#!/bin/bash

cd /home/pi/utility
./mk_ramdisk.sh

while true;
do
    cd /home/pi/picasa_fotos
    ./update_picasa_db.sh /tmp/images/picasa.db t_url /tmp/images/lista_url.txt
    ./picasa_reader.pl /tmp/images/picasa.db t_url 30

    cd /home/pi/flick_fotos
    ./flickr_tag_readers.pl cats 52565215\@N00
    ./flickr_tag_readers.pl clouds 426071\@N23
    ./flickr_tag_readers.pl hdr 89888984\@N00
    ./flickr_tag_readers.pl postcards 15214412\@N00
    ./flickr_tag_readers.pl weather 1553326\@N24
    ./flickr_tag_readers.pl paesi 23854677\@N00
    ./compose_postcards.sh /tmp/images/*.jpg

    find /tmp/images/*.jpg > /tmp/images/lista_foto.txt
    sudo find /var/www/owncloud/data/family/files/photos >> /tmp/images/lista_foto.txt

    sudo /usr/bin/pkill -KILL run_photoframe
    sudo /usr/bin/pkill -KILL run_photoframe
    sudo /usr/bin/killall fbi
    sudo /usr/bin/killall fbi
    /home/pi/run_photoframe.sh >/dev/null 2>&1 &
    sleep 14400

    cd /home/pi/utility
    ./mk_ramdisk.sh

done
