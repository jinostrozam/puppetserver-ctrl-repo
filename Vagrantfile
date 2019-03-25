# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "default" do |vm1|

    vm1.vm.box              = "generic/ubuntu1604"
      vm1.vm.hostname         = "default.role.com"
      vm1.vm.box_check_update = true
  
      vm1.vm.network :private_network,
                      ip: '192.168.60.10',
                      libvirt_netmask: '255.255.255.0',
                      libvirt__network_name: 'role-com',
                      autostart: true,
                      libvirt__domain_name: 'role.com',
                      libvirt__forward_mode: 'route',
                      libvirt__dhcp_enabled: false  
  
      vm1.vm.provision "shell", path: "scripts/install_puppet.sh"

      vm1.vm.synced_folder "./control-repo", "/etc/puppetlabs/code/environments/production"
  end
end
