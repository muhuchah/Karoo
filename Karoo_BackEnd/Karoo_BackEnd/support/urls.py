from django.urls import path
from . import views


urlpatterns = [
    path('spam_report/', views.SpamReportView.as_view(), name='SpamReport'),
    path('chatroom/<int:recipient_pk>/', views.ChatRoomView.as_view(), name='ChatRoom'),
]