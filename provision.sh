#!/bin/bash

echo "[+] Copiando clave SSH de Vagrant"
cp /home/vagrant/web_key/private_key /home/vagrant/.ssh/id_vagrant
chmod 600 /home/vagrant/.ssh/id_vagrant

echo "[+] Esperando a que web-node esté accesible por SSH..."
until ssh -o StrictHostKeyChecking=no -i /home/vagrant/.ssh/id_vagrant vagrant@192.168.101.3 "echo ok" &>/dev/null
do
  echo "Esperando conexión SSH con web-node..."
  sleep 5
done

echo "[+] Ejecutando Terraform..."
cd /vagrant
terraform init
terraform apply -auto-approve

echo "[+] Ejecutando Ansible..."
ansible-playbook -i hosts apache_playbook.yml
