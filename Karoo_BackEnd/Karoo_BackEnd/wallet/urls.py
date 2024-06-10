from django.urls import path
from . import views


urlpatterns = [
    path('', views.WalletAPIView.as_view(), name='wallet-api'),
    path('withdraw/', views.WalletWithdrawView.as_view(), name='wallet-withdraw'),
]