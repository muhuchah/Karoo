from django.urls import path
from . import views


urlpatterns = [
    path('spam_report/', views.SpamReportView.as_view(), name='SpamReport'),
    path('chatroom/<str:recipient_email>/', views.ChatRoomView.as_view(), name='ChatRoom'),
    path('send_message/', views.SendMessageView.as_view(), name='SendMessage'),
    path('cases/', views.CaseAPIView.as_view(), name='case-list'),
    path('cases/<int:case_id>/chats/', views.CaseChatsAPIView.as_view(), name='case-chats'),
    path('cases/chat/<int:chat_id>/messages/', views.SupportMessagesAPIView.as_view(), name='support-messages'),
    path('cases/chat/create_message/', views.SupportMessageCreateAPIView.as_view(), name='create-message'),
]