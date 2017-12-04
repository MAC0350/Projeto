# Sistema de Gerenciamento de Projetos

**Componentes do grupo:**

- (4460596) Bruno Guilherme Ricci Lucas
- (8936798) Eduardo Pinheiro
- (7959725) Ian Carvalho
- (8536200) Isabella Mendonça
- (8536065) Leonardo Pereira Macedo

Este diretório representa a fase 3 do projeto da disciplina **MAC0350 -- Princípios de Desenvolvimento de Software**, ministrada pelo professor João Eduardo Ferreira.


## Organização

O projeto é organizado nos seguintes arquivos e diretórios:

- `doc/`: Contém o arquivo `requirements.txt`, que possui os pacotes de Python 3
  necessários para executar o servidor.

- `gamma/`: Diretório contendo o servidor Django (em Python 3). "Gamma" refere-se ao
  nome do servidor.

- `sql/`: Contém os arquivos `queries.sql`, representando as consultas feitas no
  servidor Django em SQL puro, e `create-db.sql`, que cria e popula o banco de dados
  Postgresql.

- `pyvenv.sh`: *Script* que auxilia na criação de um virtualenv para Python 3.

- `README.md`: Este arquivo, que contém instruções para execução do servidor, bem
  como algumas observações a respeito da implementação.


## Preparação

As próximas subseções apresentam instruções para configurar e executar o servidor
Django. É necessário um sistema operacional *Unix*, com acesso ao terminal.


### Virtualenv

1. Instale o pacote virtualenv para Python 3:

        $ pip3 install --user virtualenv

2. Execute o script `pyvenv.sh` para automaticamente criar um ambiente virtual em
   Python3 e instalar as dependências em `doc/requirements.txt`:

        $ ./pyvenv.sh

3. Ative o ambiente virtual, usando o diretório `bin/` criado no passo anterior:

        $ source bin/activate


### Postgresql & Django

1. Execute o script `create-db.sql` em `sql/` para criar e popular o banco de dados
   (Postgresql). Após fazer o login neste, faça:

        => \i sql/create-db.sql

2. Exporte as seguintes variáveis de ambiente, em Bash, de acordo com sua
   configuração de banco de dados Postgresql:

    - `DATABASE_NAME`: Nome do seu banco de dados.
    - `DATABASE_USER`: Usuário do banco de dados.
    - `DATABASE_PASSWORD`: Senha para o usuário do banco de dados.
    - `DATABASE_HOST`: Nome do *host* para conexão com o banco de dados.
    - `DATABASE_PORT`: Número da porta para conexão com o banco de dados.

  Por exemplo:

        $ export DATABASE_NAME='meu_bd'

3. Dentro do diretório `gamma/`, faça as migrações necessárias para o banco de dados:

        $ cd gamma/
        $ ./manage.py makemigrations
        $ ./manage.py migrate


## Execução

Após realizar as configurações apresentadas anteiormente, use o *script* `manage.py`
em `gamma/` para executar o servidor:

    $ ./manage.py runserver

Por padrão, o servidor rodará em *localhost*, na porta 8000. Acesse a seguinte página
pelo seu navegador web: **127.0.0.1:8000**.


## Observações

A implementação do servidor fora bastante simplificada, limitando-se a algumas ações
relacionadas a **Usuário**, **Grupo** e **Projeto**.

- **Usuário:** Pode-se verificar quais os usuários cadastrados no sistema, bem como
  criar, alterar ou remover um existente.

- **Grupo:** Pode-se verificar quais os grupos existentes no sistema.

- **Projeto:** Pode-se verificar quais os projetos existentes no sistema, bem como
  criar um projeto vinculado a um grupo.

Apesar de não especificada em nossa documentação da fase 2, adicionamos a opção de
remover usuários do sistema. Tal modificação decorre da necessidade de haver ao
menos uma remoção no banco de dados, de acordo com as informações divulgadas no
fórum da disciplina.
