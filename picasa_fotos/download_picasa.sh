#!/bin/bash

cd /root/picasa_fotos
./update_picasa_db.sh /tmp/images/picasa.db t_url /tmp/images/lista_url.txt
./picasa_reader.pl /tmp/images/picasa.db t_url 20

