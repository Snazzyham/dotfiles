#!/bin/bash

 if pgrep -f docker > /dev/null; then
   dstatus=$(systemctl show -p SubState --value docker.service) 
   if [[ $(docker ps -q | wc -l) -eq 0 ]]; then
     echo "$dstatus"
   else
     dcount=$(docker ps --format '{{.Names}}' | paste -s -d, -)
   echo "$dstatus:-$dcount"
   fi
 else
   echo "Inactive"
 fi
