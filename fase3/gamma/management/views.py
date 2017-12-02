from django.shortcuts import render
from .models import Usuario

# Create your views here.
def index(request):
    return render(request, 'management/index.html')

def user(request):
    usuarios = Usuario.objects.order_by('username')
    return render(request, 'management/user.html', {'usuarios': usuarios})
