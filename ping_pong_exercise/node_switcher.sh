#!/bin/bash

TIMESTAMP=$(date +"%d-%m-%Y")
LOGFILE="node_switcher_$TIMESTAMP.log"

echo "$(date) - Script partito" >> "$LOGFILE"

while true; do
  echo "$(date) - Loop start" >> "$LOGFILE"

  vagrant ssh ubuntu-node -c '
    if [ "$(docker ps -a -q -f name=echo-ubuntu)" ]; then
      docker start echo-ubuntu
    else
      docker run -d --name echo-ubuntu -p 8080:80 ealen/echo-server
    fi
  '
  echo "$(date) - Container 1 avviato" >> "$LOGFILE"

  sleep 60

  vagrant ssh ubuntu-node -c "docker stop echo-ubuntu"

  echo "$(date) - Container 1 arrestato" >> "$LOGFILE"

  vagrant ssh debian-node -c '
    if [ "$(docker ps -a -q -f name=echo-debian)" ]; then
      docker start echo-debian
    else
      docker run -d --name echo-debian -p 8081:80 ealen/echo-server
    fi
  '
  echo "$(date) - Container 2 avviato" >> "$LOGFILE"

  sleep 60

  vagrant ssh debian-node -c "docker stop echo-debian"

  echo "$(date) - Container 2 arrestato" >> "$LOGFILE"

  vm1_STATE=$(vagrant status ubuntu-node --machine-readable | grep ",state," | cut -d',' -f4)
  vm2_STATE=$(vagrant status debian-node --machine-readable | grep ",state," | cut -d',' -f4)

  echo "$(date) - vm1_STATE=$vm1_STATE, vm2_STATE=$vm2_STATE" >> "$LOGFILE"

  if [[ "$vm1_STATE" != "running" || "$vm2_STATE" != "running" ]]; then

    
    echo "node1: $vm1_STATE, node2: $vm2_STATE" >> "$LOGFILE"
    echo "$(date) Fine dell' orchestrazione" >> "$LOGFILE"
    break
    
  fi

done

LOGFILE_DATE=$(echo "$LOGFILE" | sed -E 's/^node_switcher_(.*)\.log$/\1/')

if [[ "$TIMESTAMP" != "$LOGFILE_DATE" ]]; then
   sudo rm "$LOGFILE" || rm "$LOGFILE" 
fi

