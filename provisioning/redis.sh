#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install redis-server
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12
sudo echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu precise main" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y redis-server

# Configure redis-server
sudo mkdir /mnt/redis
sudo chown redis:redis /mnt/redis
sudo sed -i "s/port 6379/port 9360/g" /etc/redis/redis.conf
sudo sed -i 's/bind 127.0.0.1/# bind 127.0.0.1/g' /etc/redis/redis.conf
sudo sed -i "s/# requirepass foobared/requirepass $1/g" /etc/redis/redis.conf
sudo sed -i 's/dir \/var\/lib\/redis/dir \/mnt\/redis/g' /etc/redis/redis.conf
sudo echo 'vm.overcommit_memory = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl vm.overcommit_memory=1
sudo service redis-server restart

# Setup Redis backups
mkdir /home/ubuntu/redis-backups
touch /tmp/tmpcrontab
echo "0,5,10,15,20,25,30,35,40,45,50,55 * * * * sudo tar cvzf /home/ubuntu/redis-backups/dump.rdb.tar.gz /mnt/redis/dump.rdb" > /tmp/tmpcrontab
sudo crontab /tmp/tmpcrontab
