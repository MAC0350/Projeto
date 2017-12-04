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
-- Consultas, em SQL puro, realizadas no servidor Django
-----------------------------------------------------------------------

-- URL: user/
-- Busca todos os usuários cadastrados, exibindo username, email e data de criação
-- para cada um. A ordem de apresentação deve ser alfabética pelo nome do usuário.
SELECT username, email, data_horario_criacao
FROM sistema_gerenciamento_projetos.usuario
ORDER BY username;

-- URL: user/<username>/edit/
-- Internamente, busca o usuário de username especificado, exibindo username, email
-- e senha para modificação. Por exemplo, para o username 'jef', temos:
SELECT username, email, senha
FROM sistema_gerenciamento_projetos.usuario
WHERE username = 'jef';

-- URL: user/<username>/delete/
-- Remove o usuário de username especificado da tabela de usuários. Por exemplo,
-- para o username 'jef', temos:
DELETE FROM sistema_gerenciamento_projetos.usuario
WHERE username = 'jef';

-- URL: group/
-- Busca todos os grupos existentes, exibindo nome, número de integrantes e data de
-- criação para cada um. A ordem de apresentação deve ser alfabética pelo nome do
-- grupo.
SELECT g.nome, COUNT(p), g.data_horario_criacao
FROM sistema_gerenciamento_projetos.grupo AS g,
     sistema_gerenciamento_projetos.pertence_a AS p
WHERE p.grupo_id = g.id
GROUP BY g.nome, g.data_horario_criacao
ORDER BY g.nome;

-- URL: project/
-- Busca todos os projetos existentes, exibindo título, descrição, data de criação e
-- nome do grupo a qual pertence. A ordem de apresentação deve ser alfabética pela
-- data de criação.
SELECT g.nome, p.titulo, p.descricao, p.data_horario_criacao
FROM sistema_gerenciamento_projetos.projeto AS p,
     sistema_gerenciamento_projetos.participa_de AS pd,
     sistema_gerenciamento_projetos.grupo AS g
WHERE p.id = pd.projeto_id AND pd.grupo_id = g.id
ORDER BY p.data_horario_criacao;
