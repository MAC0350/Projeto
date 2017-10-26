/* ================================================================= *
 |               MAC0350 - Prof. João Eduardo Ferreira               |
 |                          Projeto - Fase 2                         |
 |                                                                   |
 | Componentes do grupo:                                             |
 | - (4460596) Bruno Guilherme Ricci Lucas                           |
 | - (8936798) Eduardo Pinheiro                                      |
 | - (7959725) Ian Carvalho                                          |
 | - (8536200) Isabella Mendonça                                     |
 | - (8536065) Leonardo Pereira Macedo                               |
 * ================================================================= */

-----------------------------------------------------------------------
-- Criação do modelo físico
-----------------------------------------------------------------------

CREATE SCHEMA sistema_gerenciamento_projetos;
SET SEARCH_PATH TO sistema_gerenciamento_projetos;

CREATE TABLE usuario
(
id SERIAL NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL,
senha VARCHAR(30) NOT NULL,
data_horario_criacao TIMESTAMP NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE mensagem
(
id SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
corpo VARCHAR(300),
data_horario TIMESTAMP NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE grupo
(
id SERIAL NOT NULL,
nome VARCHAR(50) NOT NULL UNIQUE,
data_horario_criacao TIMESTAMP NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE projeto
(
id SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
data_horario_criacao TIMESTAMP NOT NULL,
grupo_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE atividade
(
id SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(300),
prazo DATE NOT NULL,
data_horario_criacao TIMESTAMP NOT NULL,
grupo_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tag
(
cor VARCHAR(50) NOT NULL,
nome VARCHAR(50) NOT NULL,
PRIMARY KEY(cor, nome)
);

CREATE TABLE administra
(
grupo_id INTEGER NOT NULL,
user_id INTEGER NOT NULL,
data_inicio TIMESTAMP NOT NULL,
data_fim TIMESTAMP NOT NULL CHECK (data_fim > data_inicio),
PRIMARY KEY(grupo_id, user_id),
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_id) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE participa_de
(
grupo_id INTEGER NOT NULL,
user_id INTEGER NOT NULL,
data_inicio TIMESTAMP NOT NULL,
data_fim TIMESTAMP NOT NULL CHECK (data_fim > data_inicio),
PRIMARY KEY(grupo_id, user_id),
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_id) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE possui
(
atividade_id INTEGER NOT NULL,
cor_tag VARCHAR(50) NOT NULL,
nome_tag VARCHAR(50) NOT NULL,
PRIMARY KEY(atividade_id, cor_tag, nome_tag),
FOREIGN KEY(cor_tag, nome_tag) REFERENCES tag(cor, nome),
FOREIGN KEY(atividade_id) REFERENCES atividade(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE usuario_grupo
(
user_id INTEGER NOT NULL,
grupo_id INTEGER NOT NULL,
PRIMARY KEY(user_id, grupo_id),
FOREIGN KEY(user_id) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE destinatario_mensagem
(
mensagem_id INTEGER NOT NULL,
destinatario INTEGER NOT NULL,
PRIMARY KEY(mensagem_id, destinatario),
FOREIGN KEY(mensagem_id) REFERENCES mensagem(id),
FOREIGN KEY(destinatario) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE usuario_atividade
(
user_id INTEGER NOT NULL,
atividade_id INTEGER NOT NULL,
PRIMARY KEY(user_id, atividade_id),
FOREIGN KEY(user_id) REFERENCES usuario(id)
  ON DELETE RESTRICT ON UPDATE RESTRICT,
FOREIGN KEY(atividade_id) REFERENCES atividade(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE requisito_funcional
(
projeto_id INTEGER NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
PRIMARY KEY(projeto_id, titulo, descricao),
FOREIGN KEY(projeto_id) REFERENCES projeto(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE requisito_dado
(
projeto_id INTEGER NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
PRIMARY KEY(projeto_id, titulo, descricao),
FOREIGN KEY(projeto_id) REFERENCES projeto(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE convida
(
user_admin INTEGER NOT NULL,
user_convidado INTEGER NOT NULL,
grupo_id INTEGER NOT NULL,
data_horario TIMESTAMP NOT NULL,
PRIMARY KEY (user_admin, user_convidado, grupo_id),
FOREIGN KEY(user_admin) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_convidado) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE realiza
(
user_id INTEGER NOT NULL,
atividade_id INTEGER NOT NULL,
projeto_id INTEGER NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE NOT NULL,
PRIMARY KEY(user_id, atividade_id, projeto_id),
FOREIGN KEY(user_id) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(atividade_id) REFERENCES atividade(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(projeto_id) REFERENCES projeto(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE envia
(
user_remetente INTEGER NOT NULL,
user_destinatario INTEGER NOT NULL,
mensagem_id INTEGER NOT NULL,
PRIMARY KEY(user_remetente, user_destinatario, mensagem_id),
FOREIGN KEY(user_remetente) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_destinatario) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(mensagem_id) REFERENCES mensagem(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

-----------------------------------------------------------------------
-- Inserção de tuplas para povoar o BD
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Consulta envolvendo, no mínimo, 3 relações:
-- (Descrição da consulta)
-----------------------------------------------------------------------
