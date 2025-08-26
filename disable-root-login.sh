#!/bin/bash
# ------------------------------------------------------------
# Linux Server Hardening Script
# Disable root login over SSH (with backup & rollback support)
# Author: Rakshana Kannaya Muralidharan
# ------------------------------------------------------------

CONFIG_FILE="/etc/ssh/sshd_config"
BACKUP_FILE="/etc/ssh/sshd_config.bak"

# Function to disable root login
disable_root_login() {
    echo "[INFO] Disabling root login in $CONFIG_FILE ..."

    # Create backup if not exists
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "[INFO] Creating backup at $BACKUP_FILE"
        sudo cp "$CONFIG_FILE" "$BACKUP_FILE"
    else
        echo "[INFO] Backup already exists at $BACKUP_FILE"
    fi

    # Update configuration
    sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' "$CONFIG_FILE"

    # Validate SSH config before restart
    if sudo sshd -t; then
        echo "[SUCCESS] SSH config valid
