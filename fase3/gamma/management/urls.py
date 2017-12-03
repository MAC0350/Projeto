from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index, name='home'),
    url(r'^index/$', views.index, name='index'),
    url(r'^user/$', views.user, name='user'),
    url(r'^user/new/$', views.user_edit, name='user_edit'),
    url(r'^group/$', views.group, name='group'),
    url(r'^projeto/$', views.projeto, name='projeto'),
    url(r'^projeto/new/$', views.projeto_new, name='projeto_new')
]
