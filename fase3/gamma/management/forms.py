from django import forms
from .models import Usuario, Projeto


class UsuarioForm(forms.ModelForm):

    class Meta:
        model = Usuario
        fields = ('username', 'email', 'senha',)


class ProjetoForm(forms.ModelForm):

    class Meta:
        model = Projeto
        fields = ('titulo', 'descricao', 'grupo',)
