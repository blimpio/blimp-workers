#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install memcached
sudo apt-get install -y memcached

# Configure memcached
sudo sed -i 's/-m 64/-m 512/g' /etc/memcached.conf
sudo sed -i 's/-l 127.0.0.1/-l 0.0.0.0/g' /etc/memcached.conf
sudo service memcached restart
