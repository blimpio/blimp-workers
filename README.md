# Blimp Workers
Blimp workers using Vagrant with VirtualBox and Digital Ocean providers.

## Plugins
This makes use of two Vagrant plugins which can be installed by doing:

```
vagrant plugin install vagrant-digitalocean
vagrant plugin install vagrant-vbguest
```

## Setup
You need to create a file named **.env** based off **sample.env** and fill the correct values. The Vagrantfile will make use of this file to setup the environment variables needed.

You also need to copy the following ignored files into your templates folder.

- templates/ssh/authorized_keys
- templates/ssh/known_hosts
- templates/ssh/lift_github_rsa
- templates/ssh/lift_github_rsa.pub
- templates/blimp.env

## Local provision
```
vagrant up
vagrant ssh -- -l ubuntu
```

## Digital Ocean provision
```
vagrant up --provider=digital_ocean
vagrant ssh -- -l ubuntu
```