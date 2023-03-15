variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_availability_zone" {
  type    = string
  default = "us-east-1b"
}

variable "instance" {
  type    = string
  default = "InstanciaTerraform"
}

variable "instance_blueprintid" {
  type    = string
  default = "ubuntu_20_04"
}

variable "instance_bundleid" {
  type    = string
  default = "micro_2_0" #1GBRAM
  #default = "small_1_0" #2GBRAM
}

# Variáveis Setup
variable "dominio" {
  type    = string
  default = "teste.overall.cloud"
}

# Cloudflare
variable "zone_id" {
  default = "bfc746a5a6141f5bfc8179270479e2b2"
}

variable "api_cloudflare" {
  type    = string
  default = "d41d8cd98f00b204e9800998ecf8427e"
}

variable "domain" {
  default = "overall.cloud"
}
