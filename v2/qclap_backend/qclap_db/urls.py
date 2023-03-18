from django.urls import path
from . import views

urlpatterns = [
    path('api1/ping/', views.ping, name="ping"),
    path('api1/auth/', views.auth, name="auth"),
    path('api1/vm/create/', views.create_video_metadata, name="create_video_metadata"),
    path('api1/vm/<int:id>/', views.get_video_metadata, name="get_video_metadata"),
    path('api1/vm/list/', views.get_video_metadata_list, name="get_video_metadata_list"),
]