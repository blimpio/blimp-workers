#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install supervisor
sudo apt-get install -y supervisor

# Setup supervisor
sudo cp /vagrant/templates/supervisor/* /etc/supervisor/conf.d/
sudo supervisorctl reread
sudo supervisorctl update