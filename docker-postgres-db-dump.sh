#!/usr/bin/env bash

# Author: Alexander Kondratev
# Github: https://github.com/anywindblows
# You can add this script to cron task.

savedDumpsCount=14

usage() {
  cat <<EOF

Description: Script created for automatic backups of postgres database.
Usage: $(basename $0) [-c container] [-d db_name] [-u db_user]

    -c [argument] : Container ID or name
    -d [argument] : Database to dump
    -u [argument] : Database user
    -h            : Returns Help Screen

EOF
  exit
}

optspec="c:d:u:vh*:"
while getopts $optspec optchar; do
  case "${optchar}" in
  c) CONTAINER=$OPTARG ;;
  d) DATABASE=$OPTARG ;;
  u) USER=$OPTARG ;;
  h) usage ;;
  *) usage ;;
  esac
done

# Create dump
dumpPath="../dumps/docker/postgresql/$DATABASE"
dumpFile="$DATABASE"_dump_"$(date "+%Y-%m-%d_%H:%M:%S").sql"

echo "Docker Dump: Start dumping the database '$DATABASE'."

if [ ! -d "$dumpPath" ]; then
  mkdir -p "$dumpPath"
fi

docker exec -it $CONTAINER pg_dump -U $USER -d $DATABASE >"$dumpPath/$dumpFile"
echo "Dump '$dumpFile' was successfully created."

# Remove old dump
count=$(ls -1 $dumpPath | wc -l)
if [ $count -gt $savedDumpsCount ]; then
  oldest=$(ls -t $dumpPath | tail -1)
  rm $dumpPath/$oldest
fi
