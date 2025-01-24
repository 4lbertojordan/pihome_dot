#!/bin/bash

LOG_FILE0="/tmp/rclone_general.log"
LOG_FILE1="/tmp/rclone_pcgames.log"
LOG_FILE2="/tmp/rclone_pcsoftware.log"
LOG_FILE3="/tmp/rclone_music.log"

LOG_LEVEL="INFO"

WEBHOOK_URL="https://discord.com/api/webhooks/1235249345356627979/A2ThRU7Cy4OOeZKaJXZ-imO6NJKuN2MlXJ7aM1vaCFUudRUqOFmtNslfUSZIDe-iv_Gn"

# Clean log file
rm -f "$LOG_FILE"

# Send message to Discord
START_MESSAGE='{"username": "rclone", "content": "Comenzando sincronización de archivos en OneDrive."}'
curl -H "Content-Type: application/json" -d "$START_MESSAGE" "$WEBHOOK_URL"

# Run rclone in background
rclone sync -P --exclude ".recycle/**" /mnt/usb1/data_net/general onedrive:/general --log-file "$LOG_FILE0" --log-level "$LOG_LEVEL"
rclone sync -P --exclude ".recycle/**" /mnt/usb1/data_net/pcgames onedrive:/pcgames --log-file "$LOG_FILE1" --log-level "$LOG_LEVEL"
rclone sync -P --exclude ".recycle/**" /mnt/usb1/data_net/pcsoftware onedrive:/pcsoftware --log-file "$LOG_FILE2" --log-level "$LOG_LEVEL"
rclone sync -P --exclude ".recycle/**" /mnt/usb1/data_net/music onedrive:/music --log-file "$LOG_FILE3" --log-level "$LOG_LEVEL"

# Send message to Discord
BODY='{"username": "rclone", "content": "Finalizada la sincronización de archivos en OneDrive."}'
curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"