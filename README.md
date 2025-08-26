# 🛡️ Linux Server Hardening – Disable Root SSH Login

![Shell Script](https://img.shields.io/badge/Script-Bash-blue)
![Ubuntu Tested](https://img.shields.io/badge/Tested-Ubuntu%2020.04%2F22.04-brightgreen)
![Security](https://img.shields.io/badge/Focus-Security-critical)

---

## 🔒 Overview
This project provides a **Bash script** to disable **root login over SSH** on Linux servers.  

Disabling direct root SSH login is a critical security control because it:
- Reduces brute-force attack risk on privileged accounts.
- Enforces the **Principle of Least Privilege**.
- Aligns with **CIS Benchmarks** and industry best practices.

---

## ⚙️ Features
- 🔄 Creates a backup of `/etc/ssh/sshd_config` before making changes  
- ✅ Validates SSH configuration with `sshd -t`  
- 🚨 Provides clear success/failure messages  
- 🔁 Includes rollback option (`--revert`) to restore previous config  
- 💬 Fully commented and safe to use  

---

## 📋 Prerequisites
- Linux server (**tested on Ubuntu 20.04 & 22.04**)  
- Root or `sudo` privileges  
- Git installed  

---

## 🚀 Usage

Clone this repository:
```bash
git clone https://github.com/rakshana-cloudsec/linux-hardening.git
cd linux-hardening

Run the script to disable root SSH login:
sudo bash disable-root-login.sh


Rollback (revert to original configuration):
sudo bash disable-root-login.sh --revert


Verify the change:
sudo grep PermitRootLogin /etc/ssh/sshd_config


Expected output:
PermitRootLogin no

