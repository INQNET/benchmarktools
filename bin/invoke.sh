#!/bin/sh
HOMEDIR=/root/benchmarks
export LD=$HOMEDIR/logs-run-`date +%s`
mkdir -p $LD
cd $HOMEDIR/bin
sh bonnie.sh
sh postgres.sh

