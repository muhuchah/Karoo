from django.urls import path
from . import views


urlpatterns = [
    path('', views.WalletAPIView.as_view(), name='wallet-api'),
    path('withdraw/', views.WalletWithdrawView.as_view(), name='wallet-withdraw'),
    path('pay/', views.PayView.as_view(), name='wallet-pay'),
    path('zibal/verify/', views.VerifyPayView.as_view(), name='zibal-verify'),
]