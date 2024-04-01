from rest_framework import serializers
from .models import job, job_pictures
from django.http import request

class job_picturesSerializer(serializers.ModelSerializer):
    class Meta:
        model = job_pictures
        fields = '__all__'


class jobSerializer(serializers.ModelSerializer):
    pictures = job_picturesSerializer(many=True, read_only=True)
    user = serializers.HiddenField(default=serializers.CurrentUserDefault())
    Sub_category_title = serializers.SerializerMethodField()
    main_picture_url = serializers.SerializerMethodField()

    class Meta:
        model = job
        fields = ['id', 'title', 'SubCategory', 'Sub_category_title', 'user', 'main_picture', 'main_picture_url',
                  'pictures', 'description']

    def update(self, instance, validated_data):
        validated_data.pop('description', None)
        return super().update(instance, validated_data)

    def get_main_picture_url(self, obj):
        if obj.main_picture and obj.main_picture.image:
            request = self.context.get('request')
            if request is not None:
                return request.build_absolute_uri(obj.main_picture.image.url)
        return None
    def get_Sub_category_title(self, obj):
        return obj.SubCategory.title

    def to_representation(self, instance):
        data = super().to_representation(instance)
        if self.context['view'].action == 'retrieve':
            data['pictures'] = job_picturesSerializer(instance.pictures.all(), many=True).data
        else:
            data.pop('pictures', None)
        return data


class joblistSerializer(serializers.ModelSerializer):
    pictures = job_picturesSerializer(many=True, read_only=True)
    user_full_name = serializers.SerializerMethodField()
    Sub_category_title = serializers.SerializerMethodField()
    user_email = serializers.SerializerMethodField()
    user_avatar_url = serializers.SerializerMethodField()
    main_picture_url = serializers.SerializerMethodField()

    class Meta:
        model = job
        fields = [
            'id', 'title', 'Sub_category_title', 'user_full_name', 'user_email', 'user_avatar_url',
            'main_picture', 'main_picture_url', 'pictures']

    def get_user_full_name(self, obj):
        return obj.user.full_name

    def get_user_email(self, obj):
        return obj.user.email

    def get_main_picture_url(self, obj):
        if obj.main_picture and obj.main_picture.image:
            request = self.context.get('request')
            if request is not None:
                return request.build_absolute_uri(obj.main_picture.image.url)
        return None

    def get_user_avatar_url(self, obj):
        if obj.user.avatar:
            request = self.context.get('request')
            if request is not None:
                return request.build_absolute_uri(obj.user.avatar.url)
        return None

    def get_Sub_category_title(self, obj):
        return obj.SubCategory.title



