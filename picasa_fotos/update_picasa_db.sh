#!/bin/bash --

# usage: update_picasadb.sh <database.db> <table_name> <list_file>

if [ $# -ne 3 ]; then
  echo "usage: $0 <database.db> <table_name> <list_file>"
  exit 1
fi

table_name=$2
listfile=$3

#
type wget &> /dev/null
if [ $? -eq 1 ]; then
	echo "ERROR: wget not found"
	exit 1
fi

#
type xmlstarlet &> /dev/null
if [ $? -eq 1 ]; then
	echo "ERROR: xmlstarlet not found"
	exit 2
fi

# Scarico ilfile XML del servizio RSS di Picasa.
wget -N -q "http://picasaweb.google.com/data/feed/base/featured?alt=rss&kind=photo&access=public&slabel=featured&imgmax=1600&hl=en_US" -O ./picasa.xml

if [ $? -ne 0 ]; then
	echo "ERROR: downloading Picasa RSS"
	exit 3
fi

# Estraggo in un file .TXT la lista delle URL
xmlstarlet sel -N media='http://search.yahoo.com/mrss/' -t -m '//media:content' -v @url -n ./picasa.xml | grep s1600 > ${listfile} 

# Faccio l'import della lista delle URL in un DB
sqlite3 -batch $1 <<EOF
DROP TABLE ${table_name};
CREATE TABLE ${table_name} ( url text);
.import ${listfile} ${table_name}
EOF

/bin/rm -f ./picasa.xml
/bin/rm -f ${listfile}

exit 0


