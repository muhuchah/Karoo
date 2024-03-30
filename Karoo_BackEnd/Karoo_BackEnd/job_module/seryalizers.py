from rest_framework import serializers
from .models import job, job_pictures


class job_picturesSerializer(serializers.ModelSerializer):
    class Meta:
        model = job_pictures
        fields = '__all__'


class jobSerializer(serializers.ModelSerializer):
    pictures = job_picturesSerializer(many=True, read_only=True)

    class Meta:
        model = job
        fields = '__all__'
