from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone
from .models import Usuario, Grupo, PertenceA, Projeto
from .forms import UsuarioForm
from .projeto import ProjetoForm

# Create your views here.
def index(request):
    return render(request, 'management/index.html')

def user(request):
    usuarios = Usuario.objects.order_by('username')
    return render(request, 'management/user.html', {'usuarios': usuarios})

def user_new(request):
    if request.method == "POST":
        form = UsuarioForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.data_horario_criacao = timezone.now()
            user.save()
            return redirect('../')
    else:
        form = UsuarioForm()
    return render(request, 'management/user_edit.html', {'form': form})

def user_edit(request, username):
    user = get_object_or_404(Usuario, username=username)
    if request.method == "POST":
        form = UsuarioForm(request.POST, instance=user)
        if form.is_valid():
            user = form.save(commit=True)
            return redirect('../../')
    else:
        form = UsuarioForm(instance=user)
        # User can't change their username!
        form.fields['username'].widget.attrs['readonly'] = True
    return render(request, 'management/user_edit.html', {'form': form})

def user_delete(request, username):
    user = get_object_or_404(Usuario, username=username)
    if request.method == 'POST':
        Usuario.objects.get(username=username).delete()
        return redirect('../../')
    else:
        user = Usuario.objects.get(username=username)
        return render(request, 'management/user_delete.html', {'user': user})

def group(request):
    groups = Grupo.objects.order_by('nome')

    num_members = []
    for group in groups:
        count = PertenceA.objects.filter(grupo=group.id).count()
        num_members.append(count)

    names = (g.nome for g in groups)
    times = (g.data_horario_criacao for g in groups)

    name_num = zip(names, num_members, times)
    return render(request, 'management/group.html', {'groups': name_num})

def projeto(request):
    projetos = Projeto.objects.order_by('data_horario_criacao')
    return render(request, 'management/projeto.html', {'projetos': projetos})

def projeto_new(request):
    if request.method == "POST":
        form = ProjetoForm(request.POST)
        if form.is_valid():
            projeto = form.save(commit=False)
            projeto.data_horario_criacao = timezone.now()
            projeto.save()
            return redirect('../')
    else:
        form = ProjetoForm()


    groups = Grupo.objects.order_by('nome')
    return render(request, 'management/projeto_new.html', {'form': form, 'groups': groups})
