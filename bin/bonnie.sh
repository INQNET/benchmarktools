#!/bin/sh

mount -a
for x in 1 2 3; do
	cd /
	umount /srv/test
	mount /srv/test
	cd /srv/test
	sync
	bonnie -d . -u nobody > $LD/bonnie.$x.log
done

