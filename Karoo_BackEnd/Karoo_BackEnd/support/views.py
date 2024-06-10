from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework import generics
from django.db.models import Q
from django.shortcuts import get_object_or_404

from .models import SpamReport, Message, SupportIssue
from account_module.models import User
from .serializers import SpamReportSerializer, MessageSerializer, CreateSupportIssueSerializer, SupportIssueSerializer


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


class CreateSupportIssueView(APIView):
    def post(self, request):
        serializer = CreateSupportIssueSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserSupportIssuesView(generics.ListAPIView):
    serializer_class = SupportIssueSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return SupportIssue.objects.filter(user=user).order_by('timestamp')