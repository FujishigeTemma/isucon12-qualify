#!/bin/bash

set -ex
cd `dirname $0`

# SQLiteのデータベースの書きかえ

for ((i=1 ; i < 101 ; i++)); do
	echo running: $i
  sqlite3 ../initial_data/$i.db < ./tenant/override.sql
done
