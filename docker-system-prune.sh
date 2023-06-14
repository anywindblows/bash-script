#!/usr/bin/env bash

# Author: Alexander Kondratev
# Github: https://github.com/anywindblows
# You can add this script to cron task.

echo "Docker Prune: Start removing all unused containers, networks, images."

logPath="../logs/docker/$(date "+%Y-%m")-docker_prune.log"
logInfo="[$(date "+%Y-%m-%d %H:%M:%S")]\n$(docker system prune -a -f)\n"

if [ ! -d "$(dirname "$logPath")" ]; then
  mkdir -p "$(dirname "$logPath")"
fi

if [ ! -f "$logPath" ]; then
  touch "$logPath"
fi

echo -e "$logInfo" >>"$logPath" 2>&1
echo -e "$logInfo"
exit
