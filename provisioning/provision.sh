#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Setup file for logging
LOGFILE=~/vagrant_provision.log

# Start provisioning log
echo "`date +%H:%M:%S` : Start provision.sh" >> $LOGFILE

wget -qO- https://gist.github.com/jpadilla/c53aeb16c9d540aa545f/raw/setup.sh | bash
wget -qO- https://gist.github.com/jpadilla/c53aeb16c9d540aa545f/raw/memcached.sh | bash -s $1 $2 $3
wget -qO- https://gist.github.com/jpadilla/c53aeb16c9d540aa545f/raw/redis.sh | bash -s $4 $5
wget -qO- https://gist.github.com/jpadilla/c53aeb16c9d540aa545f/raw/python.sh | bash
wget -qO- https://gist.github.com/jpadilla/c53aeb16c9d540aa545f/raw/templates.sh | bash -s $1 $2 $3 $4 $5 $6 $7 $8

# Finished provisioning log
echo "`date +%H:%M:%S` : Finished provision.sh" >> $LOGFILE
