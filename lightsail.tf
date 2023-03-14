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

# Cria chave de acesso para instância
#resource "aws_lightsail_key_pair" "instance_key_pair" {
#  name = var.instance
#}

# Cria a instância na Lightsail
resource "aws_lightsail_instance" "instance" {
  name              = var.instance
  availability_zone = var.instance_availability_zone
  blueprint_id      = var.instance_blueprintid
  bundle_id         = var.instance_bundleid
  key_pair_name     = var.instance
  tags = {
    Environment = "Production"
  }
}
