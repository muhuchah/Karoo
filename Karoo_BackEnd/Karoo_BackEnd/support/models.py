from django.db import models
from job_module.models import job
from account_module.models import User

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


class SupportIssue(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='support_issues')
    topic = models.CharField(max_length=128)
    message = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    reply = models.TextField(default="NO REPLY", null=False, blank=False)

    class Meta:
        ordering = ['timestamp']

    def __str__(self):
        if self.reply == "NO REPLY":
            return f"by {self.user.username} on {self.timestamp.strftime('%Y-%m-%d %H:%M:%S')}"
        else:
            return f"Replied. Topic: {self.topic}"