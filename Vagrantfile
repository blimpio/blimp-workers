# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

# Set up environment from .env file
File.readlines(".env").each do |line|
  values = line.split("=")
  ENV[values[0].strip.gsub(/"/, '')] = values[1].strip.gsub(/"/, '')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "blimp"

  config.vm.provider :virtualbox do |provider, override|
    override.vm.box = "precise64"
    override.vm.box_url ="http://files.vagrantup.com/precise64.box"
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

  config.vm.provision "shell",
    path: "https://gist.github.com/jpadilla/c53aeb16c9d540aa545f/raw/provision.sh",
    args: [ENV['REDIS_SERVER_PASSWORD']]

end
