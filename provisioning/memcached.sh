  #!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

# Install dependencies
sudo apt-get -y install libsasl2-2 sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules libevent-dev

# Download memcached 1.4.17
sudo wget http://www.memcached.org/files/memcached-1.4.17.tar.gz

# Configure
sudo tar xfz memcached-1.4.17.tar.gz
cd memcached-1.4.17
sudo ./configure --enable-sasl

# Install memcached
sudo make install

# Create memcache group
sudo addgroup --system memcache >/dev/null

# Create memcache user
sudo adduser \
  --system \
  --disabled-login \
  --ingroup memcache \
  --home /nonexistent \
  --gecos "Memcached" \
  --shell /bin/false \
  memcache  > /dev/null

# Setup memcached scripts
sudo cp scripts/memcached-init /etc/init.d/memcached
sudo mkdir -p /usr/share/memcached/scripts
sudo cp scripts/start-memcached /usr/share/memcached/scripts/
sudo cp scripts/memcached-tool /usr/share/memcached/scripts/

# Set memcached default script
sudo echo "# Set this to no to disable memcached.\nENABLE_MEMCACHED=yes" >> /etc/default/memcached

# Copy memcached.conf to /etc/
sudo cp /vagrant/templates/memcached/memcached.conf /etc/

# Set port in memcached.conf
sudo sed -i "s/-p 11211/-p $3" /etc/memcached.conf

# Fix memcached binary paths
sudo sed -i 's/DAEMON=\/usr\/bin\/memcached/DAEMON=\/usr\/local\/bin\/memcached/g' /etc/init.d/memcached
sudo sed -i 's/my $memcached = "\/usr\/bin\/memcached";/my $memcached = "\/usr\/local\/bin\/memcached";/g' /usr/share/memcached/scripts/start-memcached

# Make sure memcached is ran on startup
sudo update-rc.d memcached defaults > /dev/null

# Create sasl2 config path
sudo mkdir "/etc/sasl2"

# Create memcached sasl2 config
sudo echo "mech_list: PLAIN" >> /etc/sasl2/memcached.conf
sudo echo "plainlog_level: 5" >> /etc/sasl2/memcached.conf
sudo echo "sasldb_path: /etc/sasl2/sasldb2" >> /etc/sasl2/memcached.conf

# Set SASL for Memcached
echo $2 | sudo saslpasswd2 -p -a memcached -c $1 -f "/etc/sasl2/sasldb2"

# Set saslauthd to run automatically on startup
sudo sed -i 's/START=no/START=yes/g' /etc/default/saslauthd

# Restart saslauthd
sudo service saslauthd restart

# Restart memcached
sudo service memcached restart
