#!/bin/bash --

# usage: geturl.sh <database.db> <table_name> <url_qta>

if [ $# -ne 3 ]; then
  echo "usage: $0 <database.db> <table_name> <url_qta>"
  exit 1
fi

t_name=$2
url_qta=$3

sqlite3 $1 "select * from ${t_name} limit (abs(random()) % ((select count(*) from t_url))-1)+1,${url_qta};"

