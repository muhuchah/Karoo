from django.urls import path
from . import views


urlpatterns = [

    path('register/', views.RegisterAPIView.as_view(), name='register-url'),
    path('account/activator/<active_code>', views.ActivateAccountAPIView.as_view(), name='account-activator-url'),
    path('forgotpassword/', views.ForgotPasswordAPIView.as_view(), name='forgot-password-url'),
    path('resetpassword/<active_code>', views.ResetPasswordView.as_view(), name='account-reset-password'),
    path('login/', views.LoginAPIView.as_view(), name='login-url'),
    path('settings/personal-info/', views.UserSettingAPIView.as_view(), name='user-personal-info-url'),
    path('settings/address-list/', views.UserAddressRetrieveAPIView.as_view(), name='user-address-list-url'),
    path('settings/address-edit/<int:pk>', views.UserAddressUpdateDestroyAPIView.as_view(), name='user-address-edit-url'),
    path('discountcode/validator/<code>', views.DiscountCodeAPIView.as_view(), name='discount-code-validator')

]