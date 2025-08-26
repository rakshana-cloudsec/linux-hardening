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
        echo "[SUCCESS] SSH config validated."
        sudo systemctl restart sshd
        echo "[SUCCESS] Root login has been disabled. SSH service restarted."
    else
        echo "[ERROR] SSH config validation failed. Rolling back..."
        sudo cp "$BACKUP_FILE" "$CONFIG_FILE"
        sudo systemctl restart sshd
        exit 1
    fi
}

# Function to rollback to backup
rollback_changes() {
    if [ -f "$BACKUP_FILE" ]; then
        echo "[INFO] Restoring backup from $BACKUP_FILE ..."
        sudo cp "$BACKUP_FILE" "$CONFIG_FILE"
        sudo systemctl restart sshd
        echo "[SUCCESS] Rollback complete. Original SSH config restored."
    else
        echo "[ERROR] No backup found at $BACKUP_FILE. Cannot rollback."
        exit 1
    fi
}

# Main logic
case "$1" in
    --revert)
        rollback_changes
        ;;
    *)
        disable_root_login
        ;;
esac
