# Gustavo Kennedy Renkel
# TF para criação de instância na Lightsail
# Utilizaz repo do Ubuntu para configs

# Exige versão dos providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    nginx = {
      source = "getstackhead/nginx"
      version = "1.3.2"
    }
  }
}

#################################################

# Define região da AWS com variável
provider "aws" {
  region                   = var.region
}

# Recebe API do Cloudflare
provider "cloudflare" {
  api_token = var.api_cloudflare
}


#################################################

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
	"sudo apt-get update"
	#"sudo apt-get -y install nginx",
	#"sudo mkdir /var/www/html/${var.dominio}",
	#"sudo systemctl start nginx"
    ]
  }

# Faz envio de comandos - baixa repo para configuração
provisioner "remote-exec" {
    inline = [
	"sudo apt-add-repository ppa:ansible/ansible --yes && sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install ansible",
	"sudo git clone https://github.com/gustavokennedy/ubuntu.git && cd ubuntu && sudo ansible-playbook playbook.yml --extra-vars 'dominio=${var.dominio} db_nome=${var.db_nome} porta_api=${var.porta_api} porta_front=${var.porta_front}'",
    ]
  }
}	
	
# Envia index padrão para Nginx
#provisioner "file" {
#	  source      = "files/index.nginx-debian.html"
#	  destination = "/tmp/index.nginx-debian.html"
#	}

# Envia arquivo de configuração do bloco do Nginx	
#provisioner "file" {
#	  source      = "files/nginx.conf"
#	  destination = "/tmp/nginx.conf"
#	}	
	
# Faz envio de comandos - copia arquivos para sudo
#provisioner "remote-exec" {
#    inline = [
#	"sudo cp /tmp/index.nginx-debian.html /var/www/html/${var.dominio}/",
#	"sudo cp /tmp/nginx.conf /etc/nginx/sites-enabled/${var.dominio}.conf"
#   ]
#  }

# Faz envio de comandos - remove default do Nginx
#provisioner "remote-exec" {
#    inline = [
#	"sudo rm /etc/nginx/sites-enabled/default"
#    ]
#  }
#}

# Libera portas
resource "aws_lightsail_instance_public_ports" "instance" {
  instance_name = aws_lightsail_instance.instance.name

# React - Frontend	
  port_info {
    protocol  = "tcp"
    from_port = 3000
    to_port   = 3000
  }
  
# NodeJS - Backend	
    port_info {
    protocol  = "tcp"
    from_port = 3333
    to_port   = 3333
  }
  
# MySQL	
    port_info {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
  }
  
# SSH	
    port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
  
# HTTP	
    port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }
	
# HTTPS	
  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }

# Zabbix-agent	
  port_info {
    protocol  = "tcp"
    from_port = 10050
    to_port   = 10050
  }

# Vite - Frontend	
  port_info {
    protocol  = "tcp"
    from_port = 5173
    to_port   = 5173
  }

}

# Cloudflare - cria registro de DNS com IP da instância	
resource "cloudflare_record" "www" {
  zone_id = var.zone_id
  name    = var.instance
  value   = aws_lightsail_instance.instance.public_ip_address
  type    = "A"
  proxied = false
}
