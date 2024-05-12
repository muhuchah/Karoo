from django.db import models
from job_module.models import job
from account_module.models import User


class SpamReport(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, blank=False, null=False)
    job = models.ForeignKey(job, on_delete=models.CASCADE, blank=False, null=False)
    reported_at = models.DateTimeField(auto_now_add=True)
    message = models.TextField()

    def __str__(self):
        return f"Spam report for job ID: {self.job.id} ({self.reported_at})"