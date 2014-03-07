#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Setup file for logging
LOGFILE=~/vagrant_provision.log

# Start provisioning log
echo "`date +%H:%M:%S` : Start provision.sh" >> $LOGFILE

wget -qO- https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/setup.sh | bash
wget -qO- https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/memcached.sh | bash -s $1 $2 $3
wget -qO- https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/redis.sh | bash -s $4 $5
wget -qO- https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/python.sh | bash
wget -qO- https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/templates.sh
wget -qO- https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/firewall.sh | bash -s $3 $5 $7

# Finished provisioning log
echo "`date +%H:%M:%S` : Finished provision.sh" >> $LOGFILE
