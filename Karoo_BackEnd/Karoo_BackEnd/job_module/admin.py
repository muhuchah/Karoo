from django.contrib import admin
from . import models
# Register your models here.

admin.site.register(models.job)
admin.site.register(models.job_pictures)
admin.site.register(models.job_comments)

