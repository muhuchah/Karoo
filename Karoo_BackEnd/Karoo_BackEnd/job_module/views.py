from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, generics, filters
from .models import job, job_pictures
from .seryalizers import jobSerializer, job_picturesSerializer, joblistSerializer


# Reverse all jobs from a user(GET,DELETE,POST(post new object),PUT(update an object))
# Notice : pictures of a job is readonly filed.
class jobUserAPIView(viewsets.ModelViewSet):
    serializer_class = jobSerializer

    def get_queryset(self):
        queryset = job.objects.filter(user=self.request.user)
        return queryset


class jobPicturesAPIView(viewsets.ModelViewSet):
    serializer_class = job_picturesSerializer

    def get_queryset(self):
        job_id = self.kwargs.get('job_id')  # Retrieve the job ID from the URL kwargs
        user = self.request.user
        queryset = job_pictures.objects.filter(job__user=user).all()
        return queryset


# Return filters of city or categories for user
class jobListAPIView(generics.ListAPIView):
    serializer_class = joblistSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['SubCategory__id', 'SubCategory__MainCategory__id', 'user__addresses__city']
    queryset = job.objects.all()


# Return search of jobs for user
class jobSearchAPIView(generics.ListAPIView):
    serializer_class = joblistSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = [
        'title', 'user__full_name', 'SubCategory__title', 'SubCategory__MainCategory__title', '=user__addresses__city']
    queryset = job.objects.all()
