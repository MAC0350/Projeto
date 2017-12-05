/* ================================================================= *
 | Script para corrigir campos 'AutoField' nos modelos em Django.    |
 | Dessa forma, o ID de uma nova tupla está correto em relação ao    |
 | conteúdo já existente na relação.                                 |
 * ================================================================= */

BEGIN;
SET SEARCH_PATH TO sistema_gerenciamento_projetos;
SELECT setval(pg_get_serial_sequence('"atividade"','id'), coalesce(max("id"), 1), max("id") IS NOT null) FROM "atividade";
SELECT setval(pg_get_serial_sequence('"grupo"','id'), coalesce(max("id"), 1), max("id") IS NOT null) FROM "grupo";
SELECT setval(pg_get_serial_sequence('"mensagem"','id'), coalesce(max("id"), 1), max("id") IS NOT null) FROM "mensagem";
SELECT setval(pg_get_serial_sequence('"projeto"','id'), coalesce(max("id"), 1), max("id") IS NOT null) FROM "projeto";
SELECT setval(pg_get_serial_sequence('"usuario"','id'), coalesce(max("id"), 1), max("id") IS NOT null) FROM "usuario";
COMMIT;
