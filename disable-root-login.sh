#!/bin/bash
# Script to disable root login via SSH

CONFIG_FILE="/etc/ssh/sshd_config"

echo "Before change:"
grep "^PermitRootLogin" $CONFIG_FILE || echo "PermitRootLogin not set"

sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' $CONFIG_FILE

echo "After change:"
grep "^PermitRootLogin" $CONFIG_FILE
echo "Root login via SSH has been disabled."

