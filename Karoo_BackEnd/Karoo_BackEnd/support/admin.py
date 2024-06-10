from django.contrib import admin
from .models import SpamReport, Message

admin.site.register(SpamReport)
admin.site.register(Message)