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
    formatted_last_updated = serializers.SerializerMethodField()

    class Meta:
        model = Chat
        fields = ['id', 'title', 'case', 'formatted_last_updated']

    def get_formatted_last_updated(self, obj):
        return obj.last_updated.strftime('%Y-%m-%d@%H:%M:%S')


class SupportMessageSerializer(serializers.ModelSerializer):
    formatted_timestamp = serializers.SerializerMethodField()

    class Meta:
        model = SupportMessage
        fields = ['content', 'formatted_timestamp', 'chat']

    def get_formatted_timestamp(self, obj):
        return obj.timestamp.strftime('%Y-%m-%d@%H:%M:%S')