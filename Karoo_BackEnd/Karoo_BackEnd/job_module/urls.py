from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter

job_user_router= DefaultRouter()
job_user_router.register('info', views.jobAPIView, basename='jobs')
job_user_router.register('pictures', views.jobPicturesAPIView, basename='job_pictures')


urlpatterns = [
    path('user/', include(job_user_router.urls)),
    path('user/', include(job_user_router.urls)),
]