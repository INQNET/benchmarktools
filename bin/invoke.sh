#!/bin/sh
HOMEDIR=/root/benchmarks

export LD=$HOMEDIR/logs-run-`date +%s`
mkdir -p $LD

hpacucli ctrl all show detail | tee $LD/hpacucli.log

cd $HOMEDIR/bin
sh bonnie.sh
sh postgres.sh

