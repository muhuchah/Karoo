from django.urls import path, include, re_path
from . import views
from rest_framework.routers import DefaultRouter

job_user_router = DefaultRouter()
job_user_router.register('info', views.jobUserAPIView, basename='job-info')
job_user_router.register('pictures', views.jobPicturesAPIView, basename='job-pictures')


urlpatterns = [
    path('user/', include(job_user_router.urls)),
    path('user/', include(job_user_router.urls)),
    path('list/', views.jobListAPIView.as_view(), name='job-list'),
    path('detail/<int:pk>', views.jobRetrieveAPIView.as_view(), name='job-detail')

]