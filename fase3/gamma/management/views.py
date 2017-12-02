from django.shortcuts import render, redirect
from django.utils import timezone
from .models import Usuario, Grupo, PertenceA
from .forms import UsuarioForm

# Create your views here.
def index(request):
    return render(request, 'management/index.html')

def user(request):
    usuarios = Usuario.objects.order_by('username')
    return render(request, 'management/user.html', {'usuarios': usuarios})

def user_edit(request):
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
