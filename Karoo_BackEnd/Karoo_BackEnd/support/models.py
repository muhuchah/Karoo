from django.db import models
from job_module.models import job
from account_module.models import User

from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils import timezone


class SpamReport(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, blank=False, null=False)
    job = models.ForeignKey(job, on_delete=models.CASCADE, blank=False, null=False)
    reported_at = models.DateTimeField(auto_now_add=True)
    message = models.TextField()

    def __str__(self):
        return f"Spam report for job ID: {self.job.id} ({self.reported_at})"


class Message(models.Model):
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['timestamp']

    def __str__(self):
        return f"Message from {self.sender} to {self.recipient} ({self.timestamp})"


class Case(models.Model):
    title = models.CharField(max_length=256)

    def __str__(self):
        return f"Case title: {self.title}"


class Chat(models.Model):
    title = models.CharField(max_length=256)
    last_updated = models.DateTimeField(auto_now=True)
    case = models.ForeignKey(Case, on_delete=models.CASCADE, related_name='chats')

    def __str__(self):
        return f"Chat title: {self.title}"

class SupportMessage(models.Model):
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_support_messages')
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    chat = models.ForeignKey(Chat, on_delete=models.CASCADE, related_name='messages')

    class Meta:
        ordering = ['timestamp']

    def save(self, *args, **kwargs):
        self.chat.last_updated = timezone.now()
        self.chat.save()
        super(SupportMessage, self).save(*args, **kwargs)