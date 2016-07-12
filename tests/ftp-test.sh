#!/usr/bin/env bash
FTPLOG=/tmp/ftplogfile
ftp -inv <<! > $FTPLOG
open localhost
user joe test
close
quit
!
#FTPLOG=/tmp/ftplogfile
#ftp -inv <<! > $FTPLOG
#open localhost
#user joe test
#put inventory
#close
#quit
#!

FTP_SUCCESS_MSG="230 OK. Current restricted directory is"
if fgrep "$FTP_SUCCESS_MSG" $FTPLOG ;then
   echo "ftp OK" && exit 0
fi

echo "ftp Error: "$OUT
exit 1