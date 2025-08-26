# 🛡️ Linux Server Hardening Toolkit – Security Report

## 🔒 Overview
This toolkit provides automated scripts to harden a Linux server against common threats.  
It includes:
1. Disabling root SSH login  
2. Configuring a secure firewall (UFW)  
3. Installing & configuring Fail2ban for brute-force protection  

The goal is to reduce the attack surface, enforce least privilege, and align with security best practices (CIS Benchmarks, NIST, ISO 27001).

---

## 🧩 Components

### 1. Disable Root SSH Login (`disable-root-login.sh`)
- **Purpose**: Prevent direct root access over SSH.  
- **Value**: Reduces brute-force risk, enforces least privilege.  
- **Rollback**: `sudo bash disable-root-login.sh --revert`

### 2. Firewall Configuration (`ufw-firewall.sh`)
- **Purpose**: Set deny-by-default firewall rules using UFW.  
- **Value**: Blocks all unauthorized inbound connections.  
- **Defaults**:
  - Deny incoming, allow outgoing
  - Allow SSH (22), HTTP (80), HTTPS (443)  
- **Rollback**: `sudo bash ufw-firewall.sh --revert`

### 3. Fail2ban Setup (`fail2ban-setup.sh`)
- **Purpose**: Protect against brute-force login attempts.  
- **Value**: Auto-bans malicious IPs after repeated failures.  
- **Defaults**:
  - Ban after 5 failed attempts in 10 minutes  
  - Ban duration: 10 minutes  
- **Rollback**: `sudo bash fail2ban-setup.sh --revert`

---

## 🛠 Usage Flow
1. Run **SSH Hardening** → disable root login  
2. Run **Firewall Setup** → configure secure UFW rules  
3. Run **Fail2ban Setup** → enable brute-force protection  

Recommended order:
```bash
sudo bash disable-root-login.sh
sudo bash ufw-firewall.sh
sudo bash fail2ban-setup.sh
```
---

## 📊 Compliance Mapping

| Control Area         | Hardening Script        | Compliance Standard        |
|----------------------|-------------------------|----------------------------|
| SSH Access Control   | disable-root-login.sh   | CIS Benchmark, NIST AC-6   |
| Network Protection   | ufw-firewall.sh         | CIS Firewall, ISO A.13.1   |
| Brute-force Defense  | fail2ban-setup.sh       | CIS, NIST SI-4             |

---

## 🔮 Future Enhancements
- Add **AIDE** for file integrity monitoring  
- Automate **patch management** for critical updates  
- Add **audit logging configuration**  
- Convert scripts into **Ansible roles** for enterprise-scale deployment  

---

## 👤 Author
**Rakshana Kannaya Muralidharan**  
Master of Cybersecurity | Cloud & Linux Security Enthusiast  

🔗 [GitHub](https://github.com/rakshana-cloudsec)

