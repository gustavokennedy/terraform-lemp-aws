# Aprendendo Terraform
Repositório para estudos com Terraform.

O fluxo de trabalho principal do Terraform consiste em três etapas principais depois de escrever sua configuração do Terraform:

* Initialize prepara o diretório de trabalho para que o Terraform possa executar a configuração.

* O Plan permite que você visualize quaisquer alterações antes de aplicá-las.

* Apply faz as alterações definidas pela configuração do Terraform para criar, atualizar ou destruir recursos. 

Quando o Terraform inicializa seu diretório de trabalho, ele configura o back-end, instala todos os provedores e módulos referidos no projeto Terraform e cria um arquivo de bloqueio, caso ainda não exista. Além disso, você pode usar o initcomando para atualizar os provedores e módulos do seu projeto. Essas etapas garantem que o Terraform use o estado, os módulos e os provedores corretos para criar, atualizar ou destruir seus recursos.

Neste tutorial, você inicializará uma configuração do Terraform que usa módulos locais e remotos, explorará o .terraformdiretório e atualizará o provedor e as versões do módulo. No processo, você aprenderá mais sobre a initfunção integral do comando no fluxo de trabalho do Terraform.
