#!/bin/bash 
# Example Bar Action Script for Linux.
# Requires: acpi, iostat.
# Tested on: Debian 10, Fedora 31.
#

#get_docker() {
#  if pgrep -f docker > /dev/null; then
#    dstatus=$(systemctl show -p SubState --value docker.service) 
#    if [[ $(docker ps -q | wc -l) -eq 0 ]]; then
#      echo "docker $dstatus"
#    else
#      dcount=$(docker ps --format '{{.Names}}' | paste -s -d, -)
#    echo -e "docker $dstatus:-$dcount"
#    fi
#  else
#    echo -e "docker Inactive"
#  fi
#}


get_date() {
	FORMAT="%H:%M | %d.%m.%Y"
	DATE=`date "+${FORMAT}"`
	echo -e "${DATE}"
}

mem() {
  used="$(free -h | grep Mem: | awk '{print $3}')"
  total="$(free -h| grep Mem: | awk '{print $2}')"

  totalh="$(free -h | grep Mem: | awk '{print $2}' | sed 's/Gi/G/')"
  usedh="$(free -h | grep Mem: | awk '{print $3}' | sed 's/Mi/M/')"

#ram="$(( 200 * $used/$total - 100 * $used/$total ))% / $totalh "
  ram="$usedh / $totalh" 

  echo -e "$ram"
}

bat() {
    batstat="$(cat /sys/class/power_supply/BAT0/status)"
    battery="$(cat /sys/class/power_supply/BAT0/capacity)"
        if [ $batstat = 'Unknown' ]; then
        batstat=""
        elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
        batstat=""
        elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
        batstat=""
        elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
        batstat=""
        elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
        batstat=""
        elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
        batstat=""
        elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
        batstat=""
    fi

    echo -e "$batstat  $battery %"
}


caddy() {

    status=$(systemctl show -p SubState --value caddy.service)

    echo -e " $status"
}

ssid() {
  if [[ -z "$INTERFACE" ]] ; then
      INTERFACE="${BLOCK_INSTANCE:-wlp0s20f3}"
  fi

  SSID=$(iw "$INTERFACE" info| awk '/ssid/ {print }' | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' | head -n 1)

  echo -e "$SSID"
}

vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "墳 $vol"
}

SLEEP_SEC=45

while :; do 
  echo " $(caddy) |   $(ssid) | $(mem) | $(vol) | $(bat) |   $(get_date) "
  sleep $SLEEP_SEC
done
