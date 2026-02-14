#!/bin/bash
# Scan the library for malicious payloads often found in "educational" hacking samples
LOG_FILE="/var/log/clamav/library_scan.log"
SCAN_DIR="/mnt/data/audiobooks"

clamscan -r -i "$SCAN_DIR" >> "$LOG_FILE"
