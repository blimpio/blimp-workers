#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

sudo cp /vagrant/templates/blimp.env /home/ubuntu/blimp.env

sudo cp /vagrant/templates/runinenv.sh /home/ubuntu/runinenv.sh
sudo cp -R /vagrant/templates/backups /home/ubuntu/

sudo mkdir /home/ubuntu/.ssh
sudo cp -R /vagrant/templates/ssh/authorized_keys /home/ubuntu/.ssh/

sudo chmod 400 /home/ubuntu/.ssh/authorized_keys
sudo chown ubuntu:ubuntu -R /home/ubuntu/
