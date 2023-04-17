#!/bin/bash

# You can add this script to cron task.
echo "Docker Prune: Start removing all unused containers, networks, images."

log_path="../logs/docker/$(date "+%Y-%m")-docker_prune.log"
log_info="[$(date "+%Y-%m-%d %H:%M:%S")]\n$(docker system prune -a -f)\n"

if [ ! -d "$(dirname "$log_path")" ]; then
  mkdir -p "$(dirname "$log_path")"
fi

if [ ! -f "$log_path" ]; then
  touch "$log_path"
fi

echo -e "$log_info" >> "$log_path" 2>&1
echo -e "$log_info"
