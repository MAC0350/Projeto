from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index, name='home'),
    url(r'^index/$', views.index, name='index'),
    url(r'^user/$', views.user, name='user'),
    url(r'^user/new/$', views.user_new, name='user_new'),
    url(r'^user/(?P<username>.+)/edit/$', views.user_edit, name='user_edit'),
    url(r'^user/(?P<username>.+)/delete/$', views.user_delete,
        name='user_delete'),
    url(r'^group/$', views.group, name='group'),
    url(r'^project/$', views.project, name='project'),
    url(r'^project/new/$', views.project_new, name='project_new')
]
