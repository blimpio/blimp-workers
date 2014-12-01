#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install PostgreSQL
sudo apt-get install postgresql
sudo -u postgres createuser --superuser $USER
sudo -u postgres createdb $USER

# Install Heroku
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Install requirements
pip install pyrax

# TODO: Setup cron
# python ~/backups/run-backup.py
