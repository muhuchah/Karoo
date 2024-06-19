from django.db.models.signals import post_save
from django.dispatch import receiver
from job_module.models import job
from .models import JobEmbedding
from chatbot.utils import create_embedding


@receiver(post_save, sender=job)
def create_job_embedding(sender, instance, created, **kwargs):
    embedding = create_embedding(instance.description)
    if created:
        # Create and save the JobEmbedding instance
        JobEmbedding.objects.create(job=instance, embedding=embedding)
    else:
        # If the job is updated, update the embedding as well
        JobEmbedding.objects.update_or_create(job=instance, defaults={'embedding': embedding})