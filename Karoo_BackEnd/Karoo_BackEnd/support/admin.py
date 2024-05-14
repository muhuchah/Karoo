from django.contrib import admin
from .models import SpamReport, Message, Case

admin.site.register(SpamReport)
admin.site.register(Message)
admin.site.register(Case)