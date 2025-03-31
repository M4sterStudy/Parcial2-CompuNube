terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "null" {}

resource "null_resource" "provision_web_node" {
  connection {
    type     = "ssh"
    host     = "192.168.101.3"
    user     = "vagrant"
    private_key = file("/home/vagrant/.ssh/id_vagrant")
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Máquina web-node lista para ser configurada con Ansible'"
    ]
  }
}
