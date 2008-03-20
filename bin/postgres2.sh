#!/bin/sh

mount -a

/etc/init.d/postgresql-8.3 stop
/etc/init.d/postgresql-8.3 start

dropdb bench
createdb bench

/usr/lib/postgresql/8.3/bin/pgbench -i bench -s 100

LF=$1
SLEEP=120

/etc/init.d/postgresql-8.3 stop
echo Sync, sleep.
sync; sleep $SLEEP

date
date +%s
for x in 1 2 3; do

	/etc/init.d/postgresql-8.3 start

	/usr/lib/postgresql/8.3/bin/pgbench -t 10000 -c 4 bench | tee $LF.$x.log

	/etc/init.d/postgresql-8.3 stop
	echo Sync, sleep.
	sync; sleep $SLEEP
done

umount /srv/db

date
date +%s

