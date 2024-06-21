from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, generics, filters, permissions, status
from rest_framework.exceptions import PermissionDenied
from .models import job, job_pictures, job_comments, skill, TimeSlot, DailySchedule
from .seryalizers import jobSerializer, job_picturesSerializer, joblistSerializer, job_commentsSerializer, skillSerializer, TimeSlotSerializer, DailyScheduleSerializer
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework.status import *
from account_module.models import Province, City
from django.db import transaction


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

    def get_object(self):
        user = self.request.user
        try:
            job_obj = job.objects.get(pk=self.kwargs['pk'], user=user)
        except job.DoesNotExist:
            return Response({'message': 'Job does not exist'}, status=status.HTTP_404_NOT_FOUND)

        return job_obj

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

    def update(self, request, *args, **kwargs):
        user_job = self.get_object()
        skills = request.data.get('skills', [])

        try:
            user_job.province = Province.objects.get(name=request.data['province'])
        except:
            print('Province does not exist')

        try:
            user_job.city = City.objects.get(name=request.data['city'])
        except:
            print('City does not exist')

        serializer = self.get_serializer(user_job, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        updated_job = serializer.save()

        updated_job.skills.clear()
        for skill_tmp in skills:
            try:
                skill_obj = skill.objects.get(title=skill_tmp['title'])
            except skill.DoesNotExist:
                message = 'Skill does not exist'
                return Response({'message': message}, status=status.HTTP_404_NOT_FOUND)

            updated_job.skills.add(skill_obj)

        serializer = jobSerializer(updated_job)

        return Response(serializer.data, status=status.HTTP_200_OK)

    def create(self, request, *args, **kwargs):
        user = self.request.user
        data = request.data

        province_name = data.get('province')
        city_name = data.get('city')
        skills = data.get('skills', [])

        try:
            province = Province.objects.get(name=province_name)
            city = City.objects.get(name=city_name)
        except (Province.DoesNotExist, City.DoesNotExist) as e:
            if isinstance(e, Province.DoesNotExist):
                message = 'Province does not exist.'
            else:
                message = 'City does not exist'
            return Response({'message': message}, status=status.HTTP_404_NOT_FOUND)

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        serializer.validated_data['province'] = province
        serializer.validated_data['city'] = city

        new_job = serializer.save(user=self.request.user)

        for skill_tmp in skills:
            try:
                skill_obj = skill.objects.get(title=skill_tmp['title'])
            except skill.DoesNotExist:
                message = 'Skill does not exist'
                return Response({'message': message}, status=status.HTTP_404_NOT_FOUND)

            new_job.skills.add(skill_obj)

        serializer = jobSerializer(new_job)

        return Response(serializer.data, status=status.HTTP_201_CREATED)

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
    filterset_fields = ['SubCategory__title', 'SubCategory__MainCategory__title', 'user__addresses__province__name',
                        'province__name', 'city__name']
    search_fields = [
        'title', 'user__full_name', 'SubCategory__title', 'SubCategory__MainCategory__title', 'province__name',
        'city__name']
    queryset = job.objects.all()

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        data = serializer.data

        for item in data:
            if 'pictures' in item:
                item.pop('pictures')
        for item in data:
            if 'comments' in item:
                item.pop('comments')

        return Response(data)


# Retrieve job details for user.
class jobRetrieveAPIView(generics.RetrieveAPIView):
    serializer_class = jobSerializer
    queryset = job.objects.all()


# Create comments on jobs
class jobCommentsCreateAPIView(generics.CreateAPIView):
    serializer_class = job_commentsSerializer
    queryset = job_comments.objects.all()

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Check if the user has already commented on this job
        user = request.user
        job_id = serializer.validated_data['job'].id
        if job_comments.objects.filter(user=user, job__id=job_id).exists():
            return Response({"error": "You have already commented on this job."}, status=status.HTTP_400_BAD_REQUEST)

        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class IsCommentOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        # Check if the user is the owner of the comment
        return obj.user == request.user


# Edite comments on jobs
class jobCommentsEditAPIView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = job_commentsSerializer
    queryset = job_comments.objects.all()
    permission_classes = [IsCommentOwner]


class jobInfoAPIView(generics.CreateAPIView):

    def post(self, request, pk):
        try: 
            curr_job = job.objects.get(id=pk)
            # Check if the logged-in user is the owner of the job
            if request.user == curr_job.user:
                curr_job.experiences = request.data.get('experiences')
                curr_job.approximation_cph = request.data.get('approximation_cph')
                curr_job.initial_cost = request.data.get('initial_cost')
                curr_job.skills.set(request.data.get('skills'))
                curr_job.save()
            else:
                return Response({'message': 'You are not allowed to change this job'}, status=HTTP_403_FORBIDDEN)
            
            return Response({'message': 'Job information updated successfully'}, status=HTTP_200_OK)
        
        except curr_job.DoesNotExist:
            return Response({'error': 'Job does not exist'}, status=HTTP_404_NOT_FOUND)


class GetAllSkill(APIView):

    def get(self, request):
        skills = skill.objects.all()
        serializer = skillSerializer(skills, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class DailyScheduleAPIView(generics.CreateAPIView):
    def post(self, request, pk):
        try:
            curr_job = job.objects.get(id=pk)
        except:
            return Response({'error': 'Job does not exist'}, status=HTTP_404_NOT_FOUND)

        if request.user == curr_job.user:
            timetable_data = request.data.get('timetable')

            daily_schedules = []

            with transaction.atomic():
                for day_data in timetable_data:
                    day_of_week = day_data['day_of_week']
                    time_slots_data = day_data['time_slots']

                    # Create DailySchedule
                    daily_schedule, created = DailySchedule.objects.get_or_create(
                        job=curr_job, day_of_week=day_of_week
                    )

                    # Clear existing TimeSlots for this DailySchedule
                    daily_schedule.time_slots.clear()

                    # Create TimeSlots
                    for slot_data in time_slots_data:
                        time_slot, created = TimeSlot.objects.get_or_create(
                            start_time=slot_data['start_time'],
                            end_time=slot_data['end_time']
                        )
                        daily_schedule.time_slots.add(time_slot)

                    daily_schedules.append(daily_schedule)

                # Set the timetable for the job
                curr_job.timetable.set(daily_schedules)
                curr_job.save()

            return Response({'message': 'Timetable updated successfully'}, status=HTTP_200_OK)
        else:
            return Response({'message': 'You are not allowed to change this job'}, status=HTTP_403_FORBIDDEN)
                