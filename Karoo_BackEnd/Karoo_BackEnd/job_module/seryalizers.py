from rest_framework import serializers
from .models import job, job_pictures


class job_picturesSerializer(serializers.ModelSerializer):
    class Meta:
        model = job_pictures
        fields = '__all__'


class jobSerializer(serializers.ModelSerializer):
    pictures = job_picturesSerializer(many=True, read_only=True)
    user = serializers.HiddenField(default=serializers.CurrentUserDefault())
    Sub_category_title = serializers.SerializerMethodField()

    class Meta:
        model = job
        fields = ['id', 'title', 'description', 'SubCategory','Sub_category_title', 'user', 'pictures']

    def get_Sub_category_title(self, obj):
        return obj.SubCategory.title


class joblistSerializer(serializers.ModelSerializer):
    pictures = job_picturesSerializer(many=True, read_only=True)
    user_full_name = serializers.SerializerMethodField()
    Sub_category_title = serializers.SerializerMethodField()
    user_email = serializers.SerializerMethodField()
    user_avatar = serializers.SerializerMethodField()

    class Meta:
        model = job
        fields = [
            'id', 'title', 'description', 'Sub_category_title', 'user_full_name', 'user_email', 'user_avatar',
            'pictures']

    def get_user_full_name(self, obj):
        return obj.user.full_name
    def get_user_email(self, obj):
        return obj.user.email

    def get_user_avatar(self, obj):
        if obj.user.avatar:
            return obj.user.avatar.url
        else:
            return None
    def get_Sub_category_title(self, obj):
        return obj.SubCategory.title
