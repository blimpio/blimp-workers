# Blimp Workers
Blimp workers using Vagrant with VirtualBox and Digital Ocean providers.

## Setup
You need to copy the following ignored files into your templates folder.

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
export DIGITAL_OCEAN_CLIENT_ID=""
export DIGITAL_OCEAN_API_KEY=""
vagrant up --provider=digital_ocean
vagrant ssh -- -l ubuntu
```