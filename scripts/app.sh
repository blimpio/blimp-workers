#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install dependencies
sudo apt-get install -y libcurl4-gnutls-dev
sudo apt-get install -y libpq-dev
sudo apt-get install -y python-dev
sudo apt-get install -y libxml2-dev libxslt-dev
sudo apt-get install -y libmemcached-dev
sudo apt-get install -y libjpeg-dev libfreetype6-dev zlib1g-dev

# Symlink for PIL dependencies
sudo ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/
sudo ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/
sudo ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/

# Install git
sudo apt-get install -y git

# Switch to ubuntu user
sudo -u ubuntu -s <<'EOF'
# Create apps directory and change to it
mkdir /home/ubuntu/apps

# Clone lift repo
git clone git@github.com:GetBlimp/lift.git /home/ubuntu/apps/lift

# Setup bare repo
git clone --bare /home/ubuntu/apps/lift /home/ubuntu/repos/lift.git

# Copy post-receive hook template
cp /vagrant/templates/repos/post-receive /home/ubuntu/repos/lift.git/hooks

# Set correct permissions in post-receive hook
chmod +x /home/ubuntu/repos/lift.git/hooks/post-receive

# Make sure our env is up to date
source /home/ubuntu/.profile

# Create virtualenv
mkvirtualenv lift

# Setup lift virtualenv postactivate hook
echo "source /home/ubuntu/blimp.env" >> /home/ubuntu/.virtualenvs/lift/bin/postactivate

# Install dependencies
pip install -r /home/ubuntu/apps/lift/requirements.txt

# Restart supervisor
sudo supervisorctl restart all
EOF
