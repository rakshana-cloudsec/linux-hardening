#!/bin/bash
# ------------------------------------------------------------
# Linux Server Hardening Script
# Install and configure Fail2ban for brute-force protection
# Author: Rakshana Kannaya Muralidharan
# ------------------------------------------------------------

JAIL_LOCAL="/etc/fail2ban/jail.local"

# Function: setup Fail2ban
setup_fail2ban() {
    echo "[INFO] Starting Fail2ban installation & configuration..."

    # Install fail2ban if not present
    if ! command -v fail2ban-client &> /dev/null; then
        echo "[INFO] Installing Fail2ban..."
        sudo apt update && sudo apt install -y fail2ban
    fi

    # Create jail.local (main config for custom rules)
    echo "[INFO] Configuring Fail2ban rules at $JAIL_LOCAL ..."
    sudo bash -c "cat > $JAIL_LOCAL" <<EOL
[DEFAULT]
# Ban IP after 5 failed attempts
bantime = 10m
findtime = 10m
maxretry = 5
backend = systemd

[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
EOL

    # Restart Fail2ban service
    echo "[INFO] Restarting Fail2ban..."
    sudo systemctl enable fail2ban
    sudo systemctl restart fail2ban

    echo "[SUCCESS] Fail2ban is installed and running."
    sudo fail2ban-client status sshd
}

# Function: rollback Fail2ban (disable & remove config)
rollback_fail2ban() {
    echo "[INFO] Disabling Fail2ban and removing custom rules..."
    sudo systemctl stop fail2ban
    sudo systemctl disable fail2ban
    sudo apt remove -y fail2ban
    sudo rm -f $JAIL_LOCAL
    echo "[SUCCESS] Fail2ban has been removed and configuration cleared."
}

# Main logic
case "$1" in
    --revert)
        rollback_fail2ban
        ;;
    *)
        setup_fail2ban
        ;;
esac
