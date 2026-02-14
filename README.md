# ZimmaBlade Hardened Homelab (NAS & Library)

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Security](https://img.shields.io/badge/Security-Hardened-green.svg)
![Access](https://img.shields.io/badge/Access-Twingate-blueviolet.svg)

A senior-tier implementation for a **ZimmaBlade NAS** focusing on high-availability, zero-trust networking, and automated security for an ethical hacking library.

---

## 🏗 Architecture Overview

This repository contains the configuration and automation scripts for a self-hosted environment built on the following stack:

* **Hardware:** ZimmaBlade (Low-power x86 NAS).
* **Networking:** Zero-Trust via **Twingate** (No open inbound ports).
* **Firewall:** **UFW** (Uncomplicated Firewall) with a "Deny All" default policy.
* **Services:** **Audiobookshelf** for hosting ethical hacking documentation and media.
* **Security:** **ClamAV** for automated antivirus scanning of uploaded library files.
* **Backups:** Redundant `rsync` logic with automated cron scheduling.

---

## 📂 Repository Structure

```text
├── setup/                 # Initialization scripts
│   ├── hardening.sh       # UFW & System-level security
│   ├── twingate_setup.sh  # Connector deployment
│   └── clamav_config.sh   # AV setup and scan scheduling
├── services/              
│   ├── docker-compose.yml # Containerized services (Audiobookshelf)
│   └── .env.example       # Environment variables template
├── scripts/               
│   ├── backup_manager.sh  # Automated backup logic
│   └── health_check.sh    # Hardware and service monitoring
└── README.md
```

## 🔒 Security Implementation
**Firewall Philosophy**

We follow the principle of least privilege. Since Twingate handles the NAT traversal, we do not require port forwarding on the router or open inbound rules on the host.

**Antivirus Integration**

To ensure the integrity of the ethical hacking library, ClamAV is configured to scan the library directory daily. This prevents the accidental spread of malware samples found in research materials.

## 🚀 Deployment

1. Initial Hardening
Clone the repo and run the hardening script

```bash
git clone [https://github.com/yourusername/homelab-zimma.git](https://github.com/yourusername/homelab-zimma.git)
cd homelab-zimma/setup
chmod +x hardening.sh
./hardening.sh
```

2. Configure Environment
Since the environment file is fictional, normaly you would populate it with (non-sensitive)
identifiers

```bash
cp services/.env.example services/.env
nano services/.env
```

3. Start Services
Launch the library and Twingate connector:

```bash
cd ../services
docker-compose up -d
```
## 🛡 Hardening Checklist
- [x] **Zero-Trust Network:** Twingate Connector handles all external routing.
- [x] **No-Password SSH:** Ed25519 Keys required; password auth disabled.
- [x] **Filesystem Integrity:** Daily ClamAV scans with automated quarantine.
- [x] **Network Lockdown:** UFW default-deny policy with logging enabled.
- [x] **Log Rotation:** System logs are rotated to prevent disk exhaustion on the ZimmaBlade.

## 🛡 Backup & Maintenance

The scripts/backup_manager.sh script performs a differential sync to a secondary mount point.

**To automate backups:**
add the following to your crontab (crontab -e):

```bash
0 2 * * * /bin/bash /home/admin/scripts/backup_manager.sh >> /var/log/homelab_backup.log 2>&1
```

## Admin Notes
- **Twingate:** Ensure the Connector is authorized in the Twingate Admin Console.
- **ZimmaBlade:** Monitor thermals during large rsync operations.
- **Library:** Audiobookshelf is configured to auto-scan the /mnt/library path for new research papers or audiobooks.

## Last Note
"Security is not a product, but a process."
