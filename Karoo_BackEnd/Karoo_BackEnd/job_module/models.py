from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils import timezone

from category_module.models import SubCategory
from account_module.models import User, Province, City


# Create your models here.

class job(models.Model):
    title = models.CharField(max_length=50, null=False, blank=False)
    description = models.TextField(null=True, blank=True)
    SubCategory = models.ForeignKey(SubCategory, on_delete=models.SET_NULL, null=True, blank=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=False, blank=False)
    main_picture = models.OneToOneField('job_pictures', on_delete=models.SET_NULL, null=True, blank=True,
                                        related_name='main_picture_of')

    skills = models.ManyToManyField('skill', related_name='jobs', blank=True)
    experiences = models.TextField(max_length=1000, null=True, blank=True)
    approximation_cph = models.CharField(max_length=100, null=True, blank=True)
    initial_cost = models.CharField(max_length=100, null=True, blank=True)

    province = models.ForeignKey(Province, on_delete=models.CASCADE, null=False, blank=False)
    city = models.ForeignKey(City, on_delete=models.CASCADE, null=False, blank=False)

    def __str__(self):
        return self.title


class job_pictures(models.Model):
    job = models.ForeignKey(job, on_delete=models.CASCADE, related_name='pictures')
    image = models.ImageField(upload_to='images/job_images', null=False, blank=False)

    def __str__(self):
        return f'job title:{self.job.title}, user:{self.job.user.email}'


# Set first picture as main picture for job model(if user saved any picture!!)
@receiver(post_save, sender=job_pictures)
def set_main_picture(sender, instance, created, **kwargs):
    if created and not instance.job.main_picture and instance.job.pictures.filter(pk=instance.pk).exists():
        instance.job.main_picture = instance
        instance.job.save()


class job_comments(models.Model):
    title = models.CharField(max_length=300)
    comment = models.TextField()
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=False, blank=False)
    job = models.ForeignKey(job, on_delete=models.CASCADE, related_name='comments')
    rating = models.PositiveSmallIntegerField(choices=((1, '1'), (2, '2'), (3, '3'), (4, '4'), (5, '5')), default=1)
    date = models.DateTimeField(default=timezone.now)

    class Meta:
        ordering = ['date']

    def __str__(self):
        return f'{self.title}, user:{self.user}, job:{self.job}'

class skill(models.Model):
    title = models.CharField(max_length=200, null=False, blank=False)
    
    def __str__(self):
        return self.title
    
