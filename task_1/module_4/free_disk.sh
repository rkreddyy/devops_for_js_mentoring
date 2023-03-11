#!/bin/bash

# default value to use if none specified
PERCENT=30

# test for command line arguement is present
if [[ $# -le 0 ]]; then
  printf "Using default value for threshold!\n"
# test if argument is an integer
# if it is, use that as percent, if not use default
else
  if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]]; then
    PERCENT=$1
  fi
fi

let "PERCENT += 0"
printf "Threshold = %d\n" $PERCENT

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
ENDCOLOR=$'\e[0m'

# df -Ph : Disk space usage with human-readable sizes.
# grep -vE (Remove matching lines)
#       E - Force grep to behave as egrep
#       v - Invert match
# awk '{ print $5,$1 }' : get the 5th and 1st words seperated by a <space>

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom|auto_home' | awk '{ print $5,$1 }' | while read data; do
  # sed s/%//g : omitting the percent sign from the output of df -Ph
  used=$(echo $data | awk '{print $1}' | sed s/%//g)
  p=$(echo $data | awk '{print $2}')
  if [ $used -ge $PERCENT ]; then
    echo -e "WARNING: The partition ${GREEN}'$p'${ENDCOLOR} has used ${RED}$used%${ENDCOLOR} of total available space - Date: $(date)"
  fi
done
