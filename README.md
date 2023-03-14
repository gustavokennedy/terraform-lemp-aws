# Aprendendo Terraform
Repositório para estudos com Terraform.

O fluxo de trabalho principal do Terraform consiste em três etapas principais depois de escrever sua configuração do Terraform:

* <b>Initialize</b> prepara o diretório de trabalho para que o Terraform possa executar a configuração.

* O <b>Plan</b> permite que você visualize quaisquer alterações antes de aplicá-las.

* E o <b>Apply</b> faz as alterações definidas pela configuração do Terraform para criar, atualizar ou destruir recursos. 

Quando o Terraform inicializa seu diretório de trabalho, ele configura o back-end, instala todos os provedores e módulos referidos no projeto Terraform e cria um arquivo de bloqueio, caso ainda não exista. Além disso, você pode usar o comando ```````init``````` para atualizar os provedores e módulos do seu projeto. 

Essas etapas garantem que o Terraform use o estado, os módulos e os provedores corretos para criar, atualizar ou destruir seus recursos.

## Rodando Playbook

Passos:

### 1. Iniciando
```shell
git clone https://github.com/gustavokennedy/terraform.git
cd terraform
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
