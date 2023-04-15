#!/bin/bash

echo "Docker cleaner: Start removing all unused containers, networks, images."

CURRENT_MOUNTH=$(date "+%Y-%m")
LOG_PATH="../logs/docker/$CURRENT_MOUNTH-docker_prune.log"

DOCKER_PRUNE=$(docker system prune -a -f)
LOG_INFO="$(date "+%Y-%m-%d %H:%M:%S") $DOCKER_PRUNE"


if [ ! -d "$(dirname "$LOG_PATH")" ]; then
  mkdir -p "$(dirname "$LOG_PATH")"
fi

if [ ! -f "$LOG_PATH" ]; then
  touch "$LOG_PATH"
fi

echo "$LOG_INFO" >> "$LOG_PATH" 2>&1
echo "Success: $LOG_INFO"

