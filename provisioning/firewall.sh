#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# ssh
ufw allow 22

# memcached
ufw allow 10514

# redis
ufw allow 9360

# enable firewall
ufw --force enable
