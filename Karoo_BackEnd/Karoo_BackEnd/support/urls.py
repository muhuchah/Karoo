from django.urls import path
from . import views


urlpatterns = [
    path('spam_report/', views.SpamReportView.as_view(), name='SpamReport'),

    # Support Issue
    path('create_issue/', views.CreateSupportIssueView.as_view(), name='create_issue'),
    path('user_issues/', views.UserSupportIssuesView.as_view(), name='user_issues'),

    # Chat
    path('chatroom/<str:recipient_email>/', views.ChatRoomView.as_view(), name='ChatRoom'),
    path('send_message/', views.SendMessageView.as_view(), name='SendMessage'),
]