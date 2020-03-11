#!/bin/sh
# 20200311
# Jan Mojzis
# Public domain.

set -e

# change directory to $AUTOPKGTEST_TMP
cd "${AUTOPKGTEST_TMP}"

./ntpserver.py -v 127.0.0.1 123 &
ntpserverpid=$!

cleanup() {
  ex=$?
  #kill ntpserver
  kill -TERM "${ntpserverpid}" 1>/dev/null 2>/dev/null || :
  kill -KILL "${ntpserverpid}" 1>/dev/null 2>/dev/null || :
  exit "${ex}"
}
trap "cleanup" EXIT TERM INT

sleep 5

ntpdate -vdq 127.0.0.1
exit 0
