# Automating infrastructure setup with AWS
# Automatizar a configuração de infraestrutura na AWS

PT-BR

No dia a dia subimos varias maquinas na Overall.Cloud as vezes com a mesma stack, como React, NodeJS, Python ou Laravel. Para cada servidor criado acabamos perdendo muito tempo. Cria ambiente, libera portas, conectar no servidor, instalar pacotes, Nginx, MySQL, certificado SSL, agentes e tudo mais, no fim acabamos demorando no mínimo 3 horas, fora os possíveis erros.

Esse repositório foi criado para automatizar a configuração de infraestrutura da Overall.Cloud, na AWS. Utilizando Terraform como IaC (infraestrutura como código) e Ansible criamos uma máquina virtual na AWS com DNS configurado no Cloudflare e todos requisitos para aplicações web, tudo em menos de 10 minutos.

* Cria uma instância na AWS Lightsail com as variáveis informadas
* Faz liberação de portas padrão de aplicações web (HTTPS, MySQL, NodeJS, React...)
* Atualiza o repositório APT da instância criada
* Instala Nginx, PHP, MySQL, PphpMyAdmin Let's Encrypt, NodeJS, NPM, Zabbix-Agent
* Configura blocos no Nginx
* Configura Certificado SSL
* Cria cronjob para renovação do Certificado SSL
* Ajustas permissões do MySQL e cria novo banco de dados

EN

On a daily basis, we upload several machines to Overall.Cloud, sometimes with the same stack, such as React, NodeJS, Python or Laravel. For each server created we end up wasting a lot of time. Create an environment, release ports, connect to the server, install packages, Nginx, MySQL, SSL certificate, agents and everything else, in the end we ended up taking at least 3 hours, apart from possible errors.

This repository was created to automate the infrastructure configuration of Overall.Cloud, on AWS. Using Terraform as IaC (Infrastructure as Code) and Ansible we create a virtual machine on AWS with DNS configured on Cloudflare and all requirements for web applications, all in less than 10 minutes.

* Creates an instance in AWS Lightsail with the informed variables
* Frees standard ports for web applications (HTTPS, MySQL, NodeJS, React...)
* Updates the APT repository of the created instance
* Installs Nginx, PHP, MySQL, PphpMyAdmin Let's Encrypt, NodeJS, NPM, Zabbix-Agent
* Configure blocks in Nginx
* Configure SSL Certificate
* Creates cronjob for SSL Certificate renewal
* Adjust MySQL permissions and create new database


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
