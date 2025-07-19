#!/bin/bash
# Disable root login over SSH

sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Root SSH login disabled successfully."
