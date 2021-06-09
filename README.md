# SIGAT
Sistema de helpdesk em PHP, JS e MySQL

## Requisitos
1. Servidor web (Apache, nginx etc)
2. Servidor MySQL
3. PHP
4. Rede Windows com controlador de domínio.

## Configuração inicial
1. Importar o arquivo `db_sigat.sql` via SGBD do MySQL
2. Configurar a URL base do sistema no `application\config\config.php`, na variável `$config['base_url']`
3. Configurar as credenciais do Active Directory no arquivo `application\libraries\ldap.php`

## Autenticação e autorização
O usuário inicial é **admin** sem senha, devendo ser desabilitado após a criação do primeiro usuário.
O `login` do usuário no SIGAT deve ser o mesmo utilizado no Active Directory, sendo que a autenticação e autorização no SIGAT é feita pelo controlador de domínio.
