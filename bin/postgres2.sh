#!/bin/sh

mount -a

/etc/init.d/postgresql-8.3 stop && sleep 5
/etc/init.d/postgresql-8.3 start && sleep 5

dropdb bench
createdb bench

/usr/lib/postgresql/8.3/bin/pgbench -i bench -s 100
echo 'CHECKPOINT; ' | psql bench

LF=$1
SLEEP=120

/etc/init.d/postgresql-8.3 stop 
echo Sync, sleep.
sync; sleep $SLEEP

date
date +%s
for x in 1; do

	/etc/init.d/postgresql-8.3 start && sleep 5

	/usr/lib/postgresql/8.3/bin/pgbench -t 100000 -c 100 bench | tee $LF.$x.log
	echo 'CHECKPOINT; ' | psql bench

	/etc/init.d/postgresql-8.3 stop
	echo Sync, sleep.
	sync; sleep $SLEEP
done

umount /srv/db

date
date +%s

