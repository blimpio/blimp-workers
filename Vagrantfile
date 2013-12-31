# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "blimp"

  config.vm.provider :virtualbox do |provider, override|
    override.vm.box = "ubuntu"
    override.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.vm.box = "digital_ocean"
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    provider.client_id = ENV["DIGITAL_OCEAN_CLIENT_ID"]
    provider.api_key = ENV["DIGITAL_OCEAN_API_KEY"]
    provider.ssh_key_name = "Vagrant"

    override.ssh.private_key_path = "~/.ssh/do_blimp_rsa"

    provider.image = "Ubuntu 12.10 x64"
    provider.size = "512MB"
    provider.region = "New York 2"
  end

  config.vm.provision "shell", path: "scripts/setup.sh"
  config.vm.provision "shell", path: "scripts/memcached.sh"
  config.vm.provision "shell", path: "scripts/redis.sh"
  config.vm.provision "shell", path: "scripts/python.sh"
  config.vm.provision "shell", path: "scripts/supervisor.sh"
  config.vm.provision "shell", path: "scripts/templates.sh"
  config.vm.provision "shell", path: "scripts/app.sh"

end
