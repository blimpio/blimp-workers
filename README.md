# Blimp Workers
Blimp workers using Vagrant with VirtualBox and Digital Ocean providers. This is an experimental setup not currently in our production environments.

## Plugins
This makes use of two Vagrant plugins which can be installed by doing:

```
vagrant plugin install vagrant-digitalocean
```

## Setup
You need to create a file named **.env** based off **sample.env** and fill the correct values. The Vagrantfile will make use of this file to setup the environment variables needed.

You also need to copy the following ignored files into your templates folder.

- templates/ssh/authorized_keys
- templates/ssh/known_hosts
- templates/blimp.env

## Local provision
```
vagrant up staging
vagrant ssh staging -- -l ubuntu
```

## Digital Ocean provision
```
vagrant up staging --provider=digital_ocean
vagrant ssh staging -- -l ubuntu
```
