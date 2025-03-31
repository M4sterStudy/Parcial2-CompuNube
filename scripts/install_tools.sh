#!/usr/bin/env bash

# Actualizamos repos
sudo apt-get update -y

# Instalamos paquetes esenciales
sudo apt-get install -y wget unzip curl software-properties-common

############################
# Instalación de Terraform #
############################
# Descargamos la última versión estable (ejemplo, 1.4.6, ajusta según prefieras)
TERRAFORM_VERSION="1.4.6"
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#########################
# Instalación de Ansible #
#########################
sudo apt-get install -y ansible

echo "Instalación de Terraform y Ansible completada."
