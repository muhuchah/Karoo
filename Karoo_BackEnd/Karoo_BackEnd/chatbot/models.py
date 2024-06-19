from django.db import models
from pgvector.django import VectorField

from account_module.models import User
from job_module.models import job


class JobEmbedding(models.Model):
    job = models.OneToOneField(job, on_delete=models.CASCADE, related_name='embedding')
    embedding = VectorField(dimensions=1536)

    def __str__(self):
        return f"Embedding for {self.job.title}"