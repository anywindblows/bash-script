#!/bin/bash

# Author: Alexander Kondratev
# Github: https://github.com/anywindblows
# You can add this script to cron task.

CURRENT_DATE=$(date +"%d_%m_%Y")
FILE_PATH="/your/gitlab/path/here/"
CLOUD_PATH="remote:your-path/here"

echo "Создание бекапа конфигурационных файлов GitLab..."
docker exec -it gitlab gitlab-ctl backup-etc
echo "_____________________"
echo "Бекап успешно создан."
echo "_____________________"
echo "Отправка в хранилище"
cd "$FILE_PATH" && rclone copy "$(ls -t | head -n1)" "$CLOUD_PATH""$CURRENT_DATE"
echo "Отправка завершена"
exit
