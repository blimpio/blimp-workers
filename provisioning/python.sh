#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install setuptools and Python dev header libraries
sudo apt-get install -y python-setuptools python-dev

# Install PostgreSQL header files
sudo apt-get install -y libpq-dev

# Install pip
sudo easy_install pip

# Upgrade setuptools
sudo pip install setuptools --upgrade

# Upgrade virtualenv
sudo pip install --upgrade virtualenv

# Install virtualenvwrapper
sudo pip install virtualenvwrapper

# Switch to ubuntu user
sudo -u ubuntu -s

# Create WORKON_HOME directory
mkdir /home/ubuntu/.virtualenvs

# Append settings to .profile
echo "export WORKON_HOME=/home/ubuntu/.virtualenvs" >> /home/ubuntu/.profile
echo "VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv" >> /home/ubuntu/.profile
echo "VIRTUALENVWRAPPER_PYTHON=/usr/bin/python" >> /home/ubuntu/.profile
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/ubuntu/.profile
