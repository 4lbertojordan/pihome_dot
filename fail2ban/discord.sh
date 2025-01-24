#!/bin/bash

# Fail2Ban Discord Notification Script
WEBHOOK_URL="https://discord.com/api/webhooks/1235249345356627979/A2ThRU7Cy4OOeZKaJXZ-imO6NJKuN2MlXJ7aM1vaCFUudRUqOFmtNslfUSZIDe-iv_Gn"

# Information to send
MESSAGE="Fail2Ban Alert:
IP: $1
Ban Time: $2 seconds
Log Info: $3"

# Send the message to Discord
curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL"
