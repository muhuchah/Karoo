from rest_framework import serializers
from .models import SpamReport, Message, Case, Chat, SupportMessage


class SpamReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = SpamReport
        fields = ['message', 'job']


class MessageSerializer(serializers.ModelSerializer):
    sender_email = serializers.SerializerMethodField()
    recipient_email = serializers.SerializerMethodField()

    class Meta:
        model = Message
        fields = ['content', 'timestamp', 'sender_email', 'recipient_email']


    def get_sender_email(self, obj):
        return obj.sender.email

    def get_recipient_email(self, obj):
        return obj.recipient.email


class CaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Case
        fields = '__all__'


class ChatSerializer(serializers.ModelSerializer):

    class Meta:
        model = Chat
        fields = '__all__'


class SupportMessageSerializer(serializers.ModelSerializer):

    class Meta:
        model = SupportMessage
        fields = ['content', 'timestamp', 'chat']