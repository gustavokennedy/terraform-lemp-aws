# Automating infrastructure setup with AWS Lightsail
Repositório para automatizar deploy de aplicações na AWS Lightsail.
Scripts for automating infrastructure setup with AWS Lightsail.

* Cria uma instância na AWS Lightsail com as variáveis informadas
* Faz liberação de portas padrão de aplicações web (HTTPS, MySQL, NodeJS, React...)
* Atualiza o repositório APT da instância criada
* Instala Nginx, PHP, MySQL, PphpMyAdmin Let's Encrypt, NodeJS, NPM, Zabbix-Agent
* Configura blocos no Nginx
* Configura Certificado SSL
* Cria cronjob para renovação do Certificado SSL
* Ajustas permissões do MySQL e cria novo banco de dados

## Rodando Playbook

Passos:

### 1. Iniciando
```shell
git clone https://github.com/gustavokennedy/terraform.git
cd terraform
```

### Para primeiro deploy


#### Conectar Terraform com AWS CLI.

```shell
aws configure
#AWS Access Key ID [None]: 
#AWS Secret Access Key [None]: 
#Default region name [None]: us-east-1
#Default output format [None]: json
```

#### Adicionar chave .pem

Copie a chave `terraform.pem` para a pasta do repositório.

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
  default = "d41d8cd98f00b204e9800998ecf8427ed41d8cd98f00b21d8cd98f00b2"
}

variable "domain" {
  default = "overall.cloud"
}

# Web (Ansible)
variable "http_port" {
  type    = string
  default = "80"
}

variable "db_nome" {
  type    = string
  default = "teste"
}

variable "porta_api" {
  type    = string
  default = "3333"
}

variable "porta_front" {
  type    = string
  default = "3000"
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
terraform apply -var 'instance=' -var 'api_cloudflare=' -var 'dominio=' -var 'db_nome='
```
### Observação

O comando `terraform plan` pode informar o erro <b>'Error: Authentication error (10000)'</b> porque não é informado a chave `api_cloudflare` correta no default.
