#!/bin/bash
# Senior Admin Hardening Script
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Only allow SSH from your local management IP if necessary
# Otherwise, rely on Twingate for access.
sudo ufw allow in on eth0 to any port 22 proto tcp

# Enable logging for audit trails
sudo ufw logging on
sudo ufw enable
