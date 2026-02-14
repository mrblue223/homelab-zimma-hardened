#!/bin/bash
# Security Audit Script for Homelab
# Scans for common misconfigurations and local privilege escalation vectors.

REPORT_FILE="/var/log/security_audit_$(date +%F).log"

echo "--- SECURITY AUDIT REPORT ---" > "$REPORT_FILE"

echo "[1] Checking for World-Writable Files in Library..." >> "$REPORT_FILE"
find /mnt/data/audiobooks -type f -perm -0002 >> "$REPORT_FILE"

echo "[2] Checking for unauthorized SUID/SGID binaries..." >> "$REPORT_FILE"
find /usr/bin /usr/sbin -perm /6000 -type f >> "$REPORT_FILE"

echo "[3] Checking Listening Ports (Should only be local/Twingate)..." >> "$REPORT_FILE"
ss -tulpn >> "$REPORT_FILE"

echo "[4] UFW Status Check..." >> "$REPORT_FILE"
ufw status numbered >> "$REPORT_FILE"

echo "Audit Complete. Report saved to $REPORT_FILE"
