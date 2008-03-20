#!/bin/sh
LF=$LD/postgres
sh postgres2.sh $LF | tee $LF.log
