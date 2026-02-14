#!/bin/bash
# Senior Admin SSH Hardening Script
# Targets: Disable passwords, enforce Ed25519, remove weak ciphers.
# WARNING: donot run this unless you know what you are doing, because you could log yourself out.
LOG_FILE="/var/log/admin_hardening.log"

echo "[$(date)] Starting SSH Hardening..." | tee -a "$LOG_FILE"

# Backup original config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Apply Hardening via sed
# 1. Disable Password Auth
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# 2. Disable Root Login (Since we use Twingate/Sudo)
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# 3. Limit maximum auth attempts to prevent brute force
sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config

# 4. Enforce SSH Protocol 2
echo "Protocol 2" >> /etc/ssh/sshd_config

# Validate and Restart
sshd -t
if [ $? -eq 0 ]; then
    systemctl restart ssh
    echo "SSH Hardened successfully." | tee -a "$LOG_FILE"
else
    echo "SSH Config Error. Reverting..." | tee -a "$LOG_FILE"
    mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
fi
