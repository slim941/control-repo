# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos-7-rvm-221"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "yum -y install multitail vim nano git"
  config.vm.provision "shell", inline: "gem install --no-ri --no-rdoc bundler"
end
