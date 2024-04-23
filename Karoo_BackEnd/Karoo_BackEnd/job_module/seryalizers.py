from rest_framework import serializers
from .models import job, job_pictures, job_comments, skill
from account_module.models import Address
from django.db.models import Avg


class job_commentsSerializer(serializers.ModelSerializer):
    user_full_name = serializers.SerializerMethodField()
    user_email = serializers.SerializerMethodField()
    user = serializers.HiddenField(default=serializers.CurrentUserDefault())

    class Meta:
        model = job_comments
        fields = '__all__'

    def get_user_full_name(self, obj):
        return obj.user.full_name

    def get_user_email(self, obj):
        return obj.user.email


class job_picturesSerializer(serializers.ModelSerializer):
    class Meta:
        model = job_pictures
        fields = '__all__'

class skillSerializer(serializers.ModelSerializer):
    class Meta:
        model = skill
        fields = '__all__'


class jobSerializer(serializers.ModelSerializer):
    pictures = job_picturesSerializer(many=True, read_only=True)
    comments = job_commentsSerializer(many=True, read_only=True)
    Sub_category_title = serializers.SerializerMethodField()
    Main_category_title = serializers.SerializerMethodField()
    user_email = serializers.SerializerMethodField()
    skills = skillSerializer(many=True, read_only=True)
    main_picture_url = serializers.SerializerMethodField()
    average_rating = serializers.SerializerMethodField()
    province_name = serializers.SerializerMethodField()
    city_name = serializers.SerializerMethodField()

    class Meta:
        model = job
        fields = ['id', 'title', 'SubCategory', 'Sub_category_title', 'Main_category_title', 'user_email',
                  'main_picture', 'main_picture_url',
                  'pictures', 'description', 'comments', 'skills', 'experiences', 'approximation_cph', 'initial_cost',
                  'province_name', 'city_name', 'average_rating']

    def update(self, instance, validated_data):
        # validated_data.pop('description', None)
        return super().update(instance, validated_data)

    def get_main_picture_url(self, obj):
        if obj.main_picture and obj.main_picture.image:
            request = self.context.get('request')
            if request is not None:
                return request.build_absolute_uri(obj.main_picture.image.url)
        return None

    def get_Sub_category_title(self, obj):
        return obj.SubCategory.title

    def get_Main_category_title(self, obj):
        return obj.SubCategory.MainCategory.title

    def get_user_email(self, obj):
        return obj.user.email

    def get_average_rating(self, obj):
        average_rating = obj.comments.aggregate(Avg('rating'))['rating__avg']
        if average_rating is None:
            return 0.0
        return average_rating

    def get_province_name(self, obj):
        return obj.province.name

    def get_city_name(self, obj):
        return obj.city.name

class joblistSerializer(serializers.ModelSerializer):
    average_rating = serializers.SerializerMethodField()

    class Meta:
        model = job
        fields = ['id', 'title', 'description', 'average_rating', 'main_picture',
                  'province', 'city']

    def get_average_rating(self, obj):
        average_rating = obj.comments.aggregate(Avg('rating'))['rating__avg']
        if average_rating is None:
            return 0.0
        return average_rating
