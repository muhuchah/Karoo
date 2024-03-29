from rest_framework import viewsets
from .models import job, job_pictures
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from .seryalizers import jobSerializer, job_picturesSerializer

# Reverse all jobs from a user(GET,DELETE,POST(post new object),PUT(update an object))
class jobAPIView(viewsets.ModelViewSet):
    serializer_class = jobSerializer

    def get_queryset(self):
        queryset = job.objects.filter(user=self.request.user)
        return queryset
