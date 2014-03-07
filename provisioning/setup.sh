#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Set UTC localtime
sudo ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Update APT package cache
sudo apt-get update -y

# Run apt-get upgrade
# sudo apt-get upgrade -y

# Install build-essential
sudo apt-get install -y build-essential

# Setup new user
sudo useradd ubuntu --create-home --shell /bin/bash

# Grant sudo access to new user with no password
sudo echo 'ubuntu  ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install fail2ban
sudo apt-get install -y fail2ban

# Install unattended-upgrades
sudo apt-get install -y unattended-upgrades

# Disallow root SSH access
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# Disallow password authentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Adjust APT update intervals
sudo cat > /etc/apt/apt.conf.d/10periodic << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

# # Copy debconf selections so that Postfix can configure itself non-interactively
# sudo cat > /tmp/postfix_selections << EOF
# postfix/mailname string sysmail.getblimp.com
# postfix/main_mailer_type string 'Internet Site'
# EOF

# # Set debconf selections for Postfix
# sudo debconf-set-selections /tmp/postfix_selections

# # Install unattended-upgrades
# sudo apt-get install -y logwatch

# # name: Make logwatch mail us daily
# sudo sed -i 's#/usr/sbin/logwatch --output mail#/usr/sbin/logwatch --output mail --mailto jpadilla@getblimp.com --detail high' /etc/cron.daily/00logwatch
