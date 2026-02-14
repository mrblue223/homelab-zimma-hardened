#!/bin/bash
# ClamAV Scan and Quarantine
SCAN_DIR="/mnt/data/audiobooks"
QUARANTINE_DIR="/mnt/data/quarantine"
LOG_FILE="/var/log/clamav/manual_scan.log"

# Create quarantine if it doesn't exist
mkdir -p "$QUARANTINE_DIR"
chmod 700 "$QUARANTINE_DIR"

echo "Starting Daily Scan: $(date)" >> "$LOG_FILE"

# Run scan: --move moves infected files to quarantine
clamscan -r --move="$QUARANTINE_DIR" "$SCAN_DIR" >> "$LOG_FILE"

# Notify if files were moved
if grep -q "Infected files: [1-9]" "$LOG_FILE"; then
    echo "ALERT: Malware detected and quarantined in $QUARANTINE_DIR"
    # Optional: Add your webhook/discord notification here
fi
