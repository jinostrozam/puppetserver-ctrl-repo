# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider :libvirt do |kvm|
    kvm.random model: 'random'
    kvm.cpu_mode  = 'host-passthrough'
    kvm.driver    = 'kvm'
    kvm.memory    = 4096
    kvm.cpus      = 2
  end

  config.ssh.forward_agent = true

  config.vm.define "puppet" do |vm1|

    vm1.vm.box              = "generic/ubuntu1604"
      vm1.vm.hostname         = "puppet"
      vm1.vm.box_check_update = true
 
      vm1.vm.network :private_network,
                      ip: '192.168.150.10',
                      libvirt_netmask: '255.255.255.0',
                      libvirt__network_name: 'autentia-local',
                      autostart: true,
                      libvirt__domain_name: 'autentia.local',
                      libvirt__forward_mode: 'route',
                      libvirt__dhcp_enabled: false  
      
      
      vm1.vm.synced_folder "./control-repo-ppserver", "/etc/puppetlabs/code/environments/production"
    
      vm1.vm.provision "shell", path: "scripts/install_puppet_server.sh"

      vm1.vm.provision "shell", :inline => <<-SHELL
      sudo echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4\n' > /etc/resolv.conf
      sudo echo "192.168.150.10 puppet.autentia.local" | sudo tee -a /etc/hosts
      sudo echo "192.168.150.20 lbalancer.autentia.local" | sudo tee -a /etc/hosts
      sudo echo "192.168.150.30 webserver1.autentia.local" | sudo tee -a /etc/hosts
      sudo echo "192.168.150.40 webserver2.autentia.local" | sudo tee -a /etc/hosts
      sudo echo -e "ndns_alt_names = puppet.autentia.local,puppet" | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
      sudo echo "" | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
      sudo /opt/puppetlabs/bin/puppet resource package puppetserver ensure=latest
      sudo /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
      sudo /opt/puppetlabs/puppet/bin/gem install gpgme --no-rdoc --no-ri
      sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml-gpg --no-rdoc --no-ri
      sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-rdoc --no-ri
      cd /etc/puppetlabs/code/environments/production
      sudo /opt/puppetlabs/puppet/bin/r10k puppetfile install --verbose
      sudo /opt/puppetlabs/bin/puppet apply --environment=production /etc/puppetlabs/code/environments/production/manifests
      SHELL

  end
end
