# Aprendendo Terraform
Repositório para estudos com Terraform.
Scripts for automating infrastructure setup with AWS Lightsail.

## Rodando Playbook

Passos:

### 1. Iniciando
```shell
git clone https://github.com/gustavokennedy/terraform.git
cd terraform
```

Delete o TF que não é necessário (S3, Lightsail...)
```shell
rm s3.tf
```

### 2. Altere as variáveis

```shell
nano variables.tf
```

```yml
#variables.tf
---
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
  default = "TerraformOC"
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
```

### 3. Aplicando

```shell
terraform init
terraform plan
terraform apply
```
ou
```shell
terraform apply -var 'instance=NomeInstancia'
```
