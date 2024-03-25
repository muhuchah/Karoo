from django.db import models
from category_module.models import SubCategory
# Create your models here.

class job(models.Model):

    title = models.CharField(max_length=50, null=False, blank=False)
    description = models.TextField(null=True, blank=True)
    image = models.ImageField(upload_to='images/jobs_images', null=True, blank=True)
    SubCategory = models.ForeignKey(SubCategory, models.SET_NULL, null=True, blank=False)

    def __str__(self):
        return self.title