from django.db import models
from category_module.models import SubCategory
from account_module.models import User
# Create your models here.

class job(models.Model):

    title = models.CharField(max_length=50, null=False, blank=False)
    description = models.TextField(null=True, blank=True)
    SubCategory = models.ForeignKey(SubCategory, on_delete=models.SET_NULL, null=True, blank=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=False, blank=False)
    def __str__(self):
        return self.title
class job_pictures(models.Model):
    job = models.ForeignKey(job, related_name='pictures', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='images/job_images', null=True, blank=True)

    def __str__(self):
        return self.job