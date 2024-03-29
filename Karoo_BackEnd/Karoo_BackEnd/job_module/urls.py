from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
router = DefaultRouter()
router.register('', views.jobAPIView, basename='job')

urlpatterns = [
    path('user/', include(router.urls))
]