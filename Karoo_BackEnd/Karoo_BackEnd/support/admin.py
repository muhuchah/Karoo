from django.contrib import admin
from .models import SpamReport, Message, SupportIssue

admin.site.register(SpamReport)
admin.site.register(Message)

class SupportIssueAdmin(admin.ModelAdmin):
    list_display = ('user', 'topic', 'message', 'timestamp', 'reply')
    list_filter = ('user', 'timestamp')
    search_fields = ('user__full_name', 'topic', 'message', 'reply')

admin.site.register(SupportIssue, SupportIssueAdmin)