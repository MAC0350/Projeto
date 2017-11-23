# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
#
# Also note: You'll have to insert the output of 'django-admin.py sqlcustom [app_label]'
# into your database.
from __future__ import unicode_literals

from django.db import models


class Administra(models.Model):
    grupo = models.ForeignKey('Grupo')
    user = models.ForeignKey('Usuario')
    data_inicio = models.DateTimeField()
    data_fim = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'administra'


class Atividade(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    titulo = models.CharField(max_length=100)
    descricao = models.CharField(max_length=300, blank=True)
    prazo = models.DateField()
    data_horario_criacao = models.DateTimeField()
    grupo = models.ForeignKey('Grupo')

    class Meta:
        managed = False
        db_table = 'atividade'


class Convida(models.Model):
    user_admin = models.ForeignKey('Usuario', db_column='user_admin')
    user_convidado = models.ForeignKey('Usuario', db_column='user_convidado')
    grupo = models.ForeignKey('Grupo')
    data_horario = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'convida'


class DestinatarioMensagem(models.Model):
    mensagem = models.ForeignKey('Mensagem')
    destinatario = models.ForeignKey('Usuario', db_column='destinatario')

    class Meta:
        managed = False
        db_table = 'destinatario_mensagem'


class Envia(models.Model):
    user_remetente = models.ForeignKey('Usuario', db_column='user_remetente')
    mensagem = models.ForeignKey('Mensagem')

    class Meta:
        managed = False
        db_table = 'envia'


class Grupo(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    nome = models.CharField(unique=True, max_length=50)
    data_horario_criacao = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'grupo'


class Mensagem(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    titulo = models.CharField(max_length=100)
    corpo = models.CharField(max_length=300, blank=True)
    data_horario = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'mensagem'


class ParticipaDe(models.Model):
    grupo = models.ForeignKey(Grupo)
    projeto = models.ForeignKey('Projeto')
    data_inicio = models.DateTimeField()
    data_fim = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'participa_de'


class PertenceA(models.Model):
    user = models.ForeignKey('Usuario')
    grupo = models.ForeignKey(Grupo)

    class Meta:
        managed = False
        db_table = 'pertence_a'


class Possui(models.Model):
    atividade = models.ForeignKey(Atividade)
    cor_tag = models.ForeignKey('Tag', db_column='cor_tag')
    nome_tag = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'possui'


class Projeto(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    titulo = models.CharField(max_length=100)
    descricao = models.CharField(max_length=500, blank=True)
    data_horario_criacao = models.DateTimeField()
    grupo = models.ForeignKey(Grupo)

    class Meta:
        managed = False
        db_table = 'projeto'


class Realiza(models.Model):
    user = models.ForeignKey('Usuario')
    atividade = models.ForeignKey(Atividade)
    projeto = models.ForeignKey(Projeto)
    data_inicio = models.DateField()
    data_fim = models.DateField()

    class Meta:
        managed = False
        db_table = 'realiza'


class RequisitoDado(models.Model):
    projeto = models.ForeignKey(Projeto)
    titulo = models.CharField(max_length=100)
    descricao = models.CharField(max_length=500)

    class Meta:
        managed = False
        db_table = 'requisito_dado'


class RequisitoFuncional(models.Model):
    projeto = models.ForeignKey(Projeto)
    titulo = models.CharField(max_length=100)
    descricao = models.CharField(max_length=500)

    class Meta:
        managed = False
        db_table = 'requisito_funcional'


class Tag(models.Model):
    cor = models.CharField(max_length=50)
    nome = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'tag'


class Usuario(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    username = models.CharField(unique=True, max_length=50)
    email = models.CharField(max_length=50)
    senha = models.CharField(max_length=30)
    data_horario_criacao = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'usuario'


class UsuarioAtividade(models.Model):
    user = models.ForeignKey(Usuario)
    atividade = models.ForeignKey(Atividade)

    class Meta:
        managed = False
        db_table = 'usuario_atividade'
