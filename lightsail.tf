terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {
  region                   = var.region
}

# Cria a instância na Lightsail
resource "aws_lightsail_instance" "instance" {
  name              = var.instance
  availability_zone = var.instance_availability_zone
  blueprint_id      = var.instance_blueprintid
  bundle_id         = var.instance_bundleid
  key_pair_name     = "terraform"
  tags = {
    Environment = "Production"
  }
	
# Conexão - Comandos e Transferências	
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("terraform.pem")
    host        = aws_lightsail_instance.instance.public_ip_address
  }

  provisioner "remote-exec" {
    inline = [
	"sudo apt-get update",
	"sudo apt-get -y install nginx",
	"sudo mkdir /var/www/html/${var.dominio}",
	"sudo systemctl start nginx"
    ]
  }
	
	provisioner "file" {
	  source      = "files/index.nginx-debian.html"
	  destination = "/var/www/html/${var.dominio}/index.nginx-debian.html"
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
