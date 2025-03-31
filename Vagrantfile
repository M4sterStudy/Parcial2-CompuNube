# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
  end

  # Máquina target (web-node) — se crea primero
  config.vm.define :web_node do |web|
    web.vm.box = "bento/ubuntu-22.04"
    web.vm.network :private_network, ip: "192.168.101.3"
    web.vm.hostname = "web-node"
  end

  # Máquina de control
  config.vm.define :control_node do |control|
    control.vm.box = "bento/ubuntu-22.04"
    control.vm.network :private_network, ip: "192.168.101.2"
    control.vm.hostname = "control-node"

    # Compartir carpeta donde está la clave de web_node
    control.vm.synced_folder ".vagrant/machines/web_node/virtualbox", "/home/vagrant/web_key"

    control.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update -y
      sudo apt-get install -y unzip curl gnupg software-properties-common
      # Instalar Terraform
      curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
      sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
      sudo apt-get update -y && sudo apt-get install terraform -y
      # Instalar Ansible
      sudo apt-add-repository --yes --update ppa:ansible/ansible
      sudo apt-get install -y ansible
    SHELL

    # Ejecutar script de Terraform + Ansible
    control.vm.provision "shell", path: "provision.sh"
  end
end
