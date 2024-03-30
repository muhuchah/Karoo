from abc import ABC

from django.contrib.auth.hashers import make_password

from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers
from .models import Address, DiscountCode
from account_module.utils.email_service import send_activation_email

User = get_user_model()


class UserSerialaizer(serializers.ModelSerializer):

    def create(self, validated_data):
        password = validated_data.pop('password')
        validated_data['password'] = make_password(password)
        return super().create(validated_data)

    class Meta:
        model = User
        fields = ['password', 'full_name', 'email']


class LoginSerializer(serializers.Serializer):
    email = serializers.CharField(required=True)
    password = serializers.CharField(write_only=True, required=True)

    def validate(self, data):
        user = authenticate(email=data.get('email'), password=data.get('password'))

        if user is not None:
            if not user.is_active:
                subject = 'Account Registration'
                template_name = 'email/activate_account.html'
                send_activation_email(user, template_name, subject)
                raise serializers.ValidationError(
                    'Your account is not active. Please check your email for the confirmation link.'
                    'We sent new link for you.')
            else:
                return user
        raise serializers.ValidationError('Invalid credentials')

    class Meta:
        model = User
        fields = ['password', 'email']


class UserSettingSerializer(serializers.ModelSerializer):
    avatar = serializers.SerializerMethodField('get_profile_image_url')

    def get_profile_image_url(self, obj):
        if obj.avatar:
            request = self.context.get('request')
            if request is not None:
                return request.build_absolute_uri(obj.avatar.url)
        return None

    class Meta:
        model = User
        fields = ['avatar', 'full_name', 'phone_number', 'email']


class UserAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'


class ForgotPasswordLinkSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(required=True)

    def validate_email(self, value):
        # Validation to check if the user with the given email exists
        try:
            user = User.objects.get(email=value)
            self.context['user'] = user
        except User.DoesNotExist:
            raise serializers.ValidationError('A user with this email does not exist.')
        return value

    def save(self):
        user = self.context['user']
        subject = 'Account Forgot Password'
        template_name = 'email/forgot_password.html'
        # The `save` method is where you should invoke the email sending
        send_activation_email(user, template_name, subject)
        # You should not raise a ValidationError here unless there is an actual error.
        return user

    class Meta:
        model = User
        fields = ['email']

class DiscountCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DiscountCode
        fields = ['discount_percent', 'is_valid']


class UserDeactivateSerializer(serializers.ModelSerializer):
    email = serializers.CharField(required=True)
    password = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = User
        fields = ['password', 'email']

    def validate(self, data):
        user = authenticate(email=data.get('email'), password=data.get('password'))

        if not user:
            raise serializers.ValidationError('Invalid credentials')
        else:
            return user