#!/bin/bash
# Disable root login over SSH with feedback

echo "Checking current PermitRootLogin setting..."
current_setting=$(grep "^PermitRootLogin" /etc/ssh/sshd_config)

echo "Before change: $current_setting"

sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

echo "Restarting SSH service..."
sudo systemctl restart sshd

echo "After change:"
grep "^PermitRootLogin" /etc/ssh/sshd_config

echo "Root SSH login disabled successfully." 
