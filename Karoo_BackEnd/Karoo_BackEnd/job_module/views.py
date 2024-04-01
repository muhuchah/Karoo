from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, generics, filters, permissions, status
from rest_framework.exceptions import PermissionDenied

from .models import job, job_pictures
from .seryalizers import jobSerializer, job_picturesSerializer, joblistSerializer
from rest_framework.response import Response


class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if view.action in ['retrieve', 'update', 'partial_update', 'destroy']:
            try:
                if isinstance(view, jobPicturesAPIView):
                    obj = job_pictures.objects.get(pk=view.kwargs['pk'])
                    return obj.job.user == request.user
                elif isinstance(view, jobUserAPIView):
                    obj = job.objects.get(pk=view.kwargs['pk'])
                    return obj.user == request.user
                else:
                    return False

            except (job_pictures.DoesNotExist, job.DoesNotExist):
                return False
        elif view.action == 'create':
            return True
        else:
            return view.action == 'list'
        return False


# Reverse all jobs from a user(GET,DELETE,POST(post new object),PUT(update an object))
# Notice : pictures of a job is readonly filed.
class jobUserAPIView(viewsets.ModelViewSet):
    serializer_class = jobSerializer
    permission_classes = [IsOwnerOrReadOnly]

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        data = serializer.data

        # Include the description field in the response
        data['description'] = instance.description

        return Response(data)

    def get_queryset(self):
        queryset = job.objects.filter(user=self.request.user)
        return queryset

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class jobPicturesAPIView(viewsets.ModelViewSet):
    serializer_class = job_picturesSerializer
    permission_classes = [IsOwnerOrReadOnly]

    def get_queryset(self):
        queryset = job_pictures.objects.filter(job__user=self.request.user)
        return queryset

    def perform_create(self, serializer):
        job = serializer.validated_data['job']

        if job.user == self.request.user:
            serializer.save()
        else:
            raise PermissionDenied("You can only create job_pictures for your own jobs.")


# Return filters of city or categories for user and Return search of jobs for user
class jobListAPIView(generics.ListAPIView):
    serializer_class = joblistSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter]
    filterset_fields = ['SubCategory__title', 'SubCategory__MainCategory__title', 'user__addresses__city']
    search_fields = [
        'title', 'user__full_name', 'SubCategory__title', 'SubCategory__MainCategory__title', '=user__addresses__city']
    queryset = job.objects.all()

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        data = serializer.data

        for item in data:
            if 'pictures' in item:
                item.pop('pictures')

        return Response(data)


# Retrieve job details for user.
class jobRetrieveAPIView(generics.RetrieveAPIView):
    serializer_class = joblistSerializer
    queryset = job.objects.all()

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        data = serializer.data

        # Include the description field in the response
        data['description'] = instance.description

        return Response(data)
