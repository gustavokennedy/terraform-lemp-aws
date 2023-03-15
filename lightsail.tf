# Gustavo Kennedy Renkel
# TF para criação de instância na Lightsail

# Exige versão dos providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

# Define região da AWS com variável
provider "aws" {
  region                   = var.region
}

# Cria a instância na Lightsail com variáveis
resource "aws_lightsail_instance" "instance" {
  name              = var.instance
  availability_zone = var.instance_availability_zone
  blueprint_id      = var.instance_blueprintid
  bundle_id         = var.instance_bundleid
  key_pair_name     = "terraform"
  tags = {
    Environment = "Production"
  }
	
# Faz conexão com instância criada por SSH (usuário ubuntu)	
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("terraform.pem")
    host        = aws_lightsail_instance.instance.public_ip_address
  }

# Faz envio de comandos - atualiza repositórios, cria pastas e reinicia serviços
provisioner "remote-exec" {
    inline = [
	"sudo apt-get update",
	"sudo apt-get -y install nginx",
	"sudo mkdir /var/www/html/${var.dominio}",
	"sudo systemctl start nginx"
    ]
  }

# Faz envio de arquivos	local da pasta files
provisioner "file" {
	  source      = "files/index.nginx-debian.html"
	  destination = "/tmp/index.nginx-debian.html"
	}
	
# Faz envio de comandos - copia arquivos para sudo
provisioner "remote-exec" {
    inline = [
	"sudo cp /tmp/index.nginx-debian.html /var/www/html/${var.dominio}/"
    ]
  }
}

# Libera portas
resource "aws_lightsail_instance_public_ports" "instance" {
  instance_name = aws_lightsail_instance.instance.name

  port_info {
    protocol  = "tcp"
    from_port = 3000
    to_port   = 3000
  }
  
    port_info {
    protocol  = "tcp"
    from_port = 3333
    to_port   = 3333
  }
  
    port_info {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
  }
  
    port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
  
    port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }
  
}
