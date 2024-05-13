from django.urls import path
from . import views


urlpatterns = [
    path('spam_report/', views.SpamReportView.as_view(), name='SpamReport'),
    path('chatroom/<str:recipient_email>/', views.ChatRoomView.as_view(), name='ChatRoom'),
]