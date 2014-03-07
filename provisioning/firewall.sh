#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# ssh
ufw allow $3

# memcached
ufw allow $1

# redis
ufw allow $2

# enable firewall
ufw --force enable
