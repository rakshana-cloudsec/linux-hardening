#!/bin/bash
# ------------------------------------------------------------
# Linux Server Hardening Script
# Configure UFW (Uncomplicated Firewall) with secure defaults
# Author: Rakshana Kannaya Muralidharan
# ------------------------------------------------------------

# Function: setup UFW firewall
setup_firewall() {
    echo "[INFO] Starting UFW firewall configuration..."

    # Install ufw if not present
    if ! command -v ufw &> /dev/null; then
        echo "[INFO] UFW not found. Installing..."
        sudo apt update && sudo apt install -y ufw
    fi

    # Reset rules (optional: safe cleanup)
    echo "[INFO] Resetting existing UFW rules..."
    sudo ufw --force reset

    # Default policies
    echo "[INFO] Setting default policies: deny incoming, allow outgoing..."
    sudo ufw default deny incoming
    sudo ufw default allow outgoing

    # Allow SSH (to avoid locking yourself out)
    echo "[INFO] Allowing SSH on port 22..."
    sudo ufw allow 22/tcp

    # Example: Allow HTTP/HTTPS
    echo "[INFO] Allowing HTTP (80) and HTTPS (443)..."
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp

    # Enable firewall
    echo "[INFO] Enabling UFW..."
    sudo ufw --force enable

    # Show status
    echo "[SUCCESS] Firewall configuration complete."
    sudo ufw status verbose
}

# Function: rollback firewall (disable UFW)
rollback_firewall() {
    echo "[INFO] Disabling UFW and restoring default accept policies..."
    sudo ufw --force disable
    sudo ufw --force reset
    echo "[SUCCESS] Firewall has been disabled and rules cleared."
}

# Main logic
case "$1" in
    --revert)
        rollback_firewall
        ;;
    *)
        setup_firewall
        ;;
esac
