/* ================================================================= *
 |               MAC0350 - Prof. João Eduardo Ferreira               |
 |                          Projeto - Fase 3                         |
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
data_horario_criacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
PRIMARY KEY(id)
);

CREATE TABLE mensagem
(
id SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
corpo VARCHAR(300),
data_horario TIMESTAMP NOT NULL DEFAULT current_timestamp,
PRIMARY KEY(id)
);

CREATE TABLE grupo
(
id SERIAL NOT NULL,
nome VARCHAR(50) NOT NULL UNIQUE,
data_horario_criacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
PRIMARY KEY(id)
);

CREATE TABLE projeto
(
id SERIAL NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(500),
data_horario_criacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
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
data_horario_criacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
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
data_inicio TIMESTAMP NOT NULL DEFAULT current_timestamp,
data_fim TIMESTAMP CHECK (data_fim > data_inicio),
PRIMARY KEY(grupo_id, user_id),
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_id) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE participa_de
(
grupo_id INTEGER NOT NULL,
projeto_id INTEGER NOT NULL,
data_inicio TIMESTAMP NOT NULL DEFAULT current_timestamp,
data_fim TIMESTAMP CHECK (data_fim > data_inicio),
PRIMARY KEY(grupo_id, projeto_id),
FOREIGN KEY(grupo_id) REFERENCES grupo(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(projeto_id) REFERENCES projeto(id)
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

CREATE TABLE pertence_a
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
mensagem_id INTEGER NOT NULL,
PRIMARY KEY(user_remetente, mensagem_id),
FOREIGN KEY(user_remetente) REFERENCES usuario(id)
  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(mensagem_id) REFERENCES mensagem(id)
  ON DELETE CASCADE ON UPDATE CASCADE
);

-----------------------------------------------------------------------
-- Inserção de tuplas para povoar o BD
-----------------------------------------------------------------------

INSERT INTO usuario (id, username, email, senha) VALUES (1, 'ian', 'ian@ime.usp.br', '123456');
INSERT INTO usuario (id, username, email, senha) VALUES (2, 'leonardo', 'leonardo@ime.usp.br', 'leonardo_123');
INSERT INTO usuario (id, username, email, senha) VALUES (3, 'isabella', 'isabella@ime.usp.br', 'isabella_123');
INSERT INTO usuario (id, username, email, senha) VALUES (4, 'bruno', 'bruno@ime.usp.br', 'bruno_123');
INSERT INTO usuario (id, username, email, senha) VALUES (5, 'eduardo', 'eduardo@ime.usp.br', 'eduardo_123');
INSERT INTO usuario (id, username, email, senha) VALUES (6, 'jef', 'jef@ime.usp.br', 'jef_123');
INSERT INTO usuario (id, username, email, senha) VALUES (7, 'joao', 'joao@ime.usp.br', 'joao_123');
INSERT INTO usuario (id, username, email, senha) VALUES (8, 'maria', 'maria@ime.usp.br', 'maria_123');
INSERT INTO usuario (id, username, email, senha) VALUES (9, 'jose', 'jose@ime.usp.br', 'jose_123');
INSERT INTO usuario (id, username, email, senha) VALUES (10, 'enzo', 'enzo@ime.usp.br', 'enzo_123');

INSERT INTO grupo (id, nome) VALUES (1, 'MAC0350');
INSERT INTO grupo (id, nome) VALUES (2, 'MAC0300');
INSERT INTO grupo (id, nome) VALUES (3, 'MAC0110');
INSERT INTO grupo (id, nome) VALUES (4, 'MAC0122');
INSERT INTO grupo (id, nome) VALUES (5, 'MAC0499');
INSERT INTO grupo (id, nome) VALUES (6, 'MAC0210');
INSERT INTO grupo (id, nome) VALUES (7, 'MAC0338');
INSERT INTO grupo (id, nome) VALUES (8, 'MAC0422');
INSERT INTO grupo (id, nome) VALUES (9, 'MAC0219');
INSERT INTO grupo (id, nome) VALUES (10, 'MAC0209');

INSERT INTO projeto (id, titulo, descricao, data_horario_criacao, grupo_id) VALUES (1, 'EP2', 'Aprofundando em SQL', current_timestamp, 1);
INSERT INTO projeto (id, titulo, descricao, data_horario_criacao, grupo_id) VALUES (2, 'P1', 'Resolucao das listas', current_timestamp, 2);
INSERT INTO projeto (id, titulo, descricao, data_horario_criacao, grupo_id) VALUES (3, 'Tutorial', 'Introducao a programacao em C', current_timestamp, 3);
INSERT INTO projeto (id, titulo, descricao, data_horario_criacao, grupo_id) VALUES (4, 'EP1', 'Estruturas de dados', current_timestamp, 4);
INSERT INTO projeto (id, titulo, descricao, data_horario_criacao, grupo_id) VALUES (5, 'Poster', 'Apresentacao final TCC', current_timestamp, 5);

INSERT INTO participa_de (grupo_id, projeto_id) VALUES (1, 1);
INSERT INTO participa_de (grupo_id, projeto_id) VALUES (2, 2);
INSERT INTO participa_de (grupo_id, projeto_id) VALUES (3, 3);
INSERT INTO participa_de (grupo_id, projeto_id) VALUES (4, 4);
INSERT INTO participa_de (grupo_id, projeto_id) VALUES (5, 5);

INSERT INTO pertence_a (user_id, grupo_id) VALUES (1, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (1, 10);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (2, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (2, 9);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (2, 2);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (3, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (3, 8);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (3, 3);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (4, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (4, 7);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (4, 4);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (5, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (5, 6);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (6, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (5, 5);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (6, 5);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (6, 6);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (7, 4);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (7, 7);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (8, 3);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (8, 8);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (9, 2);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (9, 9);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (10, 1);
INSERT INTO pertence_a (user_id, grupo_id) VALUES (10, 10);

INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (1, 6, current_timestamp, '2022-12-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (2, 6, current_timestamp, '2020-12-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (3, 6, current_timestamp, '2020-12-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (4, 6, current_timestamp, '2020-12-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (5, 6, current_timestamp, '2020-06-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (6, 6, current_timestamp, '2020-06-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (7, 6, current_timestamp, '2020-06-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (8, 6, current_timestamp, '2020-06-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (9, 6, current_timestamp, '2020-06-30');
INSERT INTO administra (grupo_id, user_id, data_inicio, data_fim) VALUES (10, 6, current_timestamp, '2020-06-30');

INSERT INTO atividade (id, titulo, descricao, prazo, data_horario_criacao, grupo_id) VALUES (1, 'Criacao Modelo fisico', 'Criar o modelo fisico para a tabela', '2017-10-26', current_timestamp, 1);
INSERT INTO atividade (id, titulo, descricao, prazo, data_horario_criacao, grupo_id) VALUES (2, 'Queries no BD', 'Realizar queries que envolvam ao menos tres relacoes no banco de dados', '2017-10-26', current_timestamp, 1);
INSERT INTO atividade (id, titulo, descricao, prazo, data_horario_criacao, grupo_id) VALUES (3, 'Entrega das listas', 'Entregar as listas resolvidas na proxima aula', '2017-10-26', current_timestamp, 2);
INSERT INTO atividade (id, titulo, descricao, prazo, data_horario_criacao, grupo_id) VALUES (4, 'P2', 'Entregar a prova resolvida no PACA', '2017-10-26', current_timestamp, 3);

INSERT INTO tag (cor, nome) VALUES ('Vermelho', 'Alta prioridade');
INSERT INTO tag (cor, nome) VALUES ('Verde', 'Entregue');

INSERT INTO possui (atividade_id, cor_tag, nome_tag) VALUES (1, 'Vermelho', 'Alta prioridade');
INSERT INTO possui (atividade_id, cor_tag, nome_tag) VALUES (3, 'Vermelho', 'Alta prioridade');
INSERT INTO possui (atividade_id, cor_tag, nome_tag) VALUES (4, 'Vermelho', 'Alta prioridade');
INSERT INTO possui (atividade_id, cor_tag, nome_tag) VALUES (2, 'Verde', 'Entregue');

INSERT INTO usuario_atividade (user_id, atividade_id) VALUES (1, 1);
INSERT INTO usuario_atividade (user_id, atividade_id) VALUES (3, 1);
INSERT INTO usuario_atividade (user_id, atividade_id) VALUES (4, 2);
INSERT INTO usuario_atividade (user_id, atividade_id) VALUES (5, 3);
INSERT INTO usuario_atividade (user_id, atividade_id) VALUES (6, 4);
INSERT INTO usuario_atividade (user_id, atividade_id) VALUES (7, 2);

INSERT INTO convida (user_admin, user_convidado, grupo_id, data_horario) VALUES (6, 1, 1, current_timestamp);
INSERT INTO convida (user_admin, user_convidado, grupo_id, data_horario) VALUES (6, 2, 1, current_timestamp);
INSERT INTO convida (user_admin, user_convidado, grupo_id, data_horario) VALUES (6, 3, 1, current_timestamp);
INSERT INTO convida (user_admin, user_convidado, grupo_id, data_horario) VALUES (6, 4, 1, current_timestamp);
INSERT INTO convida (user_admin, user_convidado, grupo_id, data_horario) VALUES (6, 5, 1, current_timestamp);

INSERT INTO mensagem (id, titulo, corpo, data_horario) VALUES (1, 'Entrega tarefa', 'Ola, professor. Entreguei a atividade 1 que estava sob minha responsabilidade', current_timestamp);
INSERT INTO mensagem (id, titulo, corpo, data_horario) VALUES (2, 'Status Grupo', 'Ola, jef. Acredito que vamos atrasar, precisamos melhorar a distribuicao das tarefas', current_timestamp);
INSERT INTO mensagem (id, titulo, corpo, data_horario) VALUES (3, 'Ajuda', 'Jef, nao estou conseguindo avancar na tarefa pois estou tendo dificuldades em comunicar com o BD, pode me ajudar?', current_timestamp);
INSERT INTO mensagem (id, titulo, corpo, data_horario) VALUES (4, 'Tarefa', 'Ola, Isa. Como esta a entrega da tarefa? Preciso dela para dar continuidade ao meu trabalho', current_timestamp);
INSERT INTO mensagem (id, titulo, corpo, data_horario) VALUES (5, 'Cobranca', 'Vamos, Ian, termina essa tarefa, temos um prazo a cumprir', current_timestamp);

INSERT INTO envia (user_remetente, mensagem_id) VALUES (1, 1);
INSERT INTO envia (user_remetente, mensagem_id) VALUES (3, 2);
INSERT INTO envia (user_remetente, mensagem_id) VALUES (2, 3);
INSERT INTO envia (user_remetente, mensagem_id) VALUES (5, 4);
INSERT INTO envia (user_remetente, mensagem_id) VALUES (3, 5);
