# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2017-12-01 18:16
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Administra',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_inicio', models.DateTimeField()),
                ('data_fim', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'administra',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Atividade',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('titulo', models.CharField(max_length=100)),
                ('descricao', models.CharField(blank=True, max_length=300)),
                ('prazo', models.DateField()),
                ('data_horario_criacao', models.DateTimeField()),
            ],
            options={
                'db_table': 'atividade',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Convida',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_horario', models.DateTimeField()),
            ],
            options={
                'db_table': 'convida',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DestinatarioMensagem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'destinatario_mensagem',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Envia',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'envia',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Grupo',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('nome', models.CharField(max_length=50, unique=True)),
                ('data_horario_criacao', models.DateTimeField()),
            ],
            options={
                'db_table': 'grupo',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Mensagem',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('titulo', models.CharField(max_length=100)),
                ('corpo', models.CharField(blank=True, max_length=300)),
                ('data_horario', models.DateTimeField()),
            ],
            options={
                'db_table': 'mensagem',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ParticipaDe',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_inicio', models.DateTimeField()),
                ('data_fim', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'participa_de',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='PertenceA',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'pertence_a',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Possui',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome_tag', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'possui',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Projeto',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('titulo', models.CharField(max_length=100)),
                ('descricao', models.CharField(blank=True, max_length=500)),
                ('data_horario_criacao', models.DateTimeField()),
            ],
            options={
                'db_table': 'projeto',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Realiza',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_inicio', models.DateField()),
                ('data_fim', models.DateField()),
            ],
            options={
                'db_table': 'realiza',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='RequisitoDado',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('titulo', models.CharField(max_length=100)),
                ('descricao', models.CharField(max_length=500)),
            ],
            options={
                'db_table': 'requisito_dado',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='RequisitoFuncional',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('titulo', models.CharField(max_length=100)),
                ('descricao', models.CharField(max_length=500)),
            ],
            options={
                'db_table': 'requisito_funcional',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cor', models.CharField(max_length=50)),
                ('nome', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tag',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Usuario',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('username', models.CharField(max_length=50, unique=True)),
                ('email', models.CharField(max_length=50)),
                ('senha', models.CharField(max_length=30)),
                ('data_horario_criacao', models.DateTimeField()),
            ],
            options={
                'db_table': 'usuario',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='UsuarioAtividade',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'usuario_atividade',
                'managed': False,
            },
        ),
    ]
