# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "bknight/docker-host"
  config.vm.box_version = "1.0.1"
  config.vm.hostname = "vagrant"

  config.vm.network "forwarded_port", guest: 3000, host: 3000
end
