#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Make sure ufw is installed
sudo apt-get install -y ufw

# ssh
ufw allow 22

# memcached
ufw allow $1

# redis
ufw allow $2

# enable firewall
ufw --force enable
