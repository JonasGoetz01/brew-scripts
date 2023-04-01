#!/bin/bash

# get command and message as arguments
cmd=$1
msg=$2

# define spinner characters
spinner="/-\|"

# start spinner
spin() {
  while :; do
    for i in ${spinner}; do
      echo -ne "\r${i} ${msg}"
      sleep 0.1
    done
  done
}

# start spinner in the background
spin &

# get PID of spinner
SPIN_PID=$!

# execute command and get exit status
eval "${cmd}"
status=$?

# kill spinner
kill ${SPIN_PID}

# remove spinner character and print result message
if [ ${status} -eq 0 ]; then
  echo -e "\r\033[K${msg} ✔"
else
  echo -e "\r\033[K${msg} ✘"
fi

# exit with command status
exit ${status}
