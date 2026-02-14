#!/bin/bash
# Simple, robust backup to an external drive or remote mount
SOURCE="/mnt/data/"
DEST="/mnt/backups/daily_snap/"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Starting backup at $TIMESTAMP"
rsync -avz --delete "$SOURCE" "$DEST"
