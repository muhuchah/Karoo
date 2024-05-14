from django.contrib import admin
from .models import SpamReport, Message, Case, Chat, SupportMessage

admin.site.register(SpamReport)
admin.site.register(Message)
admin.site.register(Case)
admin.site.register(Chat)
admin.site.register(SupportMessage)