#!/bin/bash

set -ex
cd `dirname $0`

# SQLiteのデータベースの書きかえ

for ((i=1 ; i < 140 ; i++)); do
	echo running: $i
  sqlite3 ../tenant_db/$i.db < ./tenant/override.sql
done
