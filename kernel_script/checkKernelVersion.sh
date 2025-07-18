#!/bin/bash

checkOs=$(hostnamectl | grep "Operating System" | awk '{print $3}')

case $checkOs in
  Debian)
    current_kernel=$(uname -r)
    latest_kernel=$(sudo apt-cache search linux-image | grep -v -- '-rt' | tail -n1 | awk '{print $1}' | cut -d'-' -f3-)
    ;;
  Rocky)
    current_kernel=$(uname -r | cut -d'.' -f1-6) #correzione del nome della variabile e dei parametri da estrarre nella flag -f del comando cut
    latest_kernel=$(yum list kernel | tail -n 1 | awk '{print $2}')
    ;;
esac

isLatestVersion=false

if [[ "$current_kernel" == "$latest_kernel" ]]; then
  isLatestVersion=true
  echo $isLatestVersion
else
  echo $isLatestVersion
fi
