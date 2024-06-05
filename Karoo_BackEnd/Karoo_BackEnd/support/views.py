from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from django.db.models import Q
from django.shortcuts import get_object_or_404

from .models import SpamReport, Message, Case, Chat, SupportMessage
from account_module.models import User
from .serializers import SpamReportSerializer, MessageSerializer, CaseSerializer, ChatSerializer, SupportMessageSerializer


class SpamReportView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, format=None):
        serializer = SpamReportSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class SendMessageView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        data = request.data

        try:
            recipient = User.objects.get(email=data.get('recipient_email'))
        except User.DoesNotExist:
            return Response({'error': 'Recipient not found'}, status=status.HTTP_404_NOT_FOUND)

        serializer = MessageSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(sender=user, recipient=recipient)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ChatRoomView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, recipient_email):
        user = request.user

        try:
            recipient = User.objects.get(email=recipient_email)
            messages = Message.objects.filter(
                (Q(sender=user) & Q(recipient=recipient)) |
                (Q(sender=recipient) & Q(recipient=user))
            )

            serializer = MessageSerializer(messages, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error': 'Recipient not found'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class CaseAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        cases = Case.objects.all()
        serializer = CaseSerializer(cases, many=True)
        return Response(serializer.data)


class CaseChatsAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get (self, request, case_id):
        chats = Chat.objects.filter(case_id=case_id)
        serializer = ChatSerializer(chats, many=True)
        return Response(serializer.data)

    def post(self, request, case_id):
        data = request.data
        data['case'] = case_id  # Add the case_id to the data
        serializer = ChatSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class SupportMessagesAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, chat_id):
        try:
            user = request.user
            messages = SupportMessage.objects.filter(chat_id=chat_id, sender=user)
            serializer = SupportMessageSerializer(messages, many=True)
            return Response(serializer.data)
        except SupportMessage.DoesNotExist:
            return Response({'error': 'Chat not found'}, status=status.HTTP_404_NOT_FOUND)


class SupportMessageCreateAPIView(APIView):
    def post(self, request, *args, **kwargs):
        serializer = SupportMessageSerializer(data=request.data)
        if serializer.is_valid():
            sender = request.user
            content = serializer.validated_data.get('content')
            chat = serializer.validated_data.get('chat')
            message = SupportMessage.objects.create(sender=sender, content=content, chat=chat)
            return Response(SupportMessageSerializer(message).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)