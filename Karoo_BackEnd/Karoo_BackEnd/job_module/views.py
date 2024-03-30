from rest_framework import viewsets
from .models import job, job_pictures
from django.db.models import Q
from .seryalizers import jobSerializer, job_picturesSerializer


# Reverse all jobs from a user(GET,DELETE,POST(post new object),PUT(update an object))
# Notice : pictures of a job is readonly filed.
class jobAPIView(viewsets.ModelViewSet):
    serializer_class = jobSerializer

    def get_queryset(self):
        queryset = job.objects.filter(user=self.request.user)
        return queryset


class jobPicturesAPIView(viewsets.ModelViewSet):
    serializer_class = job_picturesSerializer


    def get_queryset(self):
        job_id = self.kwargs.get('job_id')  # Retrieve the job ID from the URL kwargs
        user = self.request.user
        queryset = job_pictures.objects.filter(Q(job__user=user)).all()
        return queryset
