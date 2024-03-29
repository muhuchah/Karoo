from django.urls import path
from . import views
urlpatterns = [
    path('maincategories/list', views.MainCategoryListAPIView.as_view(), name='maincategory'),
    path('subcategories/list/<int:pk>', views.SubCategoryListAPIView.as_view(), name='subcategory')
]