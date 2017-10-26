CREATE SCHEMA mac350_ep2;
SET SEARCH_PATH TO mac350_ep2;

CREATE TABLE usuario
(
id SERIAL NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
senha VARCHAR(30) NOT NULL,
email VARCHAR (50) NOT NULL UNIQUE,
data_horario_criacao TIMESTAMP NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE mensagem
(
numero_mensagem SERIAL NOT NULL,
nome_remetente VARCHAR(50) NOT NULL,
titulo VARCHAR(100) NOT NULL,
corpo VARCHAR(100),
data_horario TIMESTAMP NOT NULL,
PRIMARY KEY(numero_mensagem),
);

CREATE TABLE grupo
(
id SERIAL NOT NULL,
nome_grupo VARCHAR(50) NOT NULL,
data_horario_criacao TIMESTAMP NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE atividade
(
numero_atividade SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
corpo VARCHAR(100),
prazo DATE NOT NULL,
data_horario_criacao TIMESTAMP NOT NULL,
grupoid INTEGER NOT NULL;
PRIMARY KEY(numero_atividade),
FOREIGN KEY(grupoid) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE projeto
(
id SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
data_horario_criacao TIMESTAMP NOT NULL,
grupoid INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(grupo) REFERENCES grupo(id)
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
grupoid INTEGER NOT NULL,
userid INTEGER NOT NULL,
dt_inicio TIMESTAMP NOT NULL,
dt_fim TIMESTAMP NOT NULL CHECK (dt_fim > dt_inicio),
PRIMARY KEY(grupoid, userid),
FOREIGN KEY(grupoid) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
FOREIGN KEY(userid) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE participa_de
(
grupoid INTEGER NOT NULL,
userid INTEGER NOT NULL,
dt_inicio TIMESTAMP NOT NULL,
dt_fim TIMESTAMP NOT NULL CHECK (dt_fim > dt_inicio),
PRIMARY KEY(grupoid, userid),
FOREIGN KEY(grupoid) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
FOREIGN KEY(userid) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE possui
(
numero_atividade INTEGER NOT NULL,
cor_tag VARCHAR(50) NOT NULL,
nome_tag VARCHAR(50) NOT NULL,
PRIMARY KEY(numero_atividade, cor_tag, nome_tag),
FOREIGN KEY(cor_tag, nome_tag) REFERENCES tag(cor, nome),
FOREIGN KEY(numero_atividade) REFERENCES atividade(numero_atividade)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE usuario_grupo
(
userid INTEGER NOT NULL,
grupoid INTEGER NOT NULL,
PRIMARY KEY(userid, grupoid),
FOREIGN KEY(userid) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(grupoid) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE nome_destinatario
(
numero_mensagem INTEGER NOT NULL,
destinatario INTEGER NOT NULL,
  PRIMARY KEY(destinatario),
  FOREIGN KEY(numero_mensagem) REFERENCES mensagem(numero_mensagem)
  FOREIGN KEY(destinatario) REFERENCES usuario(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE usuario_atividade
(
userid INTEGER NOT NULL,
numero_atividade INTEGER NOT NULL,
PRIMARY KEY(userid, numero_mensagem),
FOREIGN KEY(userid) REFERENCES usuario(id)
  ON DELETE RESTRICT ON UPDATE RESTRICT,
FOREIGN KEY(numero_atividade) REFERENCES atividade(numero_atividade)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE requisito_funcional
(
projetoid INTEGER NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
PRIMARY KEY(projetoid, titulo, descricao),
FOREIGN KEY(projetoid) REFERENCES projeto(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE requisito_dado
(
projetoid INTEGER NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
PRIMARY KEY(projetoid, titulo, descricao),
FOREIGN KEY(projetoid) REFERENCES projeto(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE convida
(
user_admin INTEGER NOT NULL,
user_convidado INTEGER NOT NULL,
grupoid INTEGER NOT NULL,
data_horario TIMESTAMP NOT NULL,
PRIMARY KEY (user_admin, user_convidado, grupoid),
FOREIGN KEY(user_admin) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
FOREIGN KEY(user_convidado) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
FOREIGN KEY(grupoid) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE realiza
(
userid INTEGER NOT NULL,
numero_atividade INTEGER NOT NULL,
numero_projeto INTEGER NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE NOT NULL,
PRIMARY KEY(userid, numero_atividade, numero_projeto),
FOREIGN KEY(userid) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(numero_atividade) REFERENCES atividade(numero_atividade)
  ON DELETE CASCADE ON UPDATE CASCADE
FOREIGN KEY(numero_projeto) REFERENCES projeto(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE envia
(
user_remetente INTEGER NOT NULL,
user_destinatario INTEGER NOT NULL,
numero_mensagem INTEGER NOT NULL,
PRIMARY KEY(user_remetente, user_destinatario, numero_mensagem),
FOREIGN KEY(user_remetente) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_destinatario) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(numero_mensagem) REFERENCES mensagem(numero_mensagem)
  ON DELETE CASCADE ON UPDATE CASCADE
);