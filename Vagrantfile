# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
Vagrant.configure("2") do |config|



  config.vm.box = "generic/rocky9"
  config.vm.box_version = "4.3.12"
  config.vm.provision "shell", inline: <<-SHELL
      sudo setenforce 0
      sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
    SHELL
  config.vm.provision "ansible" do |ans|
    ans.verbose = "v"
    ans.playbook = "wide-config-playbook.yml"
  end

  ################### CLUSTER A ###################
  config.vm.define "controllerA" do |ctl|
    
    ctl.vm.hostname = "controllerA"
    ctl.vm.provider "libvirt" do |lv|
      lv.cpus = 2
    end
  
    ctl.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "controller-playbook.yml"
    end
    # ctl.trigger.after :provision do |trigger|
    #   trigger.run_remote =  {inline: "touch /tmp/testfile"}
    # end
  end
  
  config.vm.define "computeA" do |cput|
    cput.vm.hostname = "computeA"
    cput.vm.provider "libvirt" do |lv|
      lv.cpus = 2
    end
    cput.vm.provision "ansible" do |ans|
      ans.verbose = "v"
      ans.playbook = "compute-playbook.yml"
    end
  end
################### CLUSTER B ###################
  config.vm.define "controllerB" do |ctl|
    
    ctl.vm.hostname = "controllerB"
    ctl.vm.provider "libvirt" do |lv|
      lv.cpus = 2
    end
  
    ctl.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "controller-playbook.yml"
    end
  end

  config.vm.define "computeB" do |cput|
    cput.vm.hostname = "computeB"
    cput.vm.provider "libvirt" do |lv|
      lv.cpus = 2
    end
    cput.vm.provision "ansible" do |ans|
      ans.verbose = "v"
      ans.playbook = "compute-playbook.yml"
    end
  end

  # config.trigger.after :provision do |trigger|
  #   trigger.name = "test"
  #   trigger.only_on = "controllerA"
  #   trigger.run_remote = {inline: "touch /tmp/testfile"}
  # end

end
 # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
