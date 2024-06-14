from django.contrib.auth import get_user_model
from rest_framework import serializers
from .models import Wallet, Payment

User = get_user_model()


class WalletSerializer(serializers.ModelSerializer):
    class Meta:
        model = Wallet
        fields = ['user', 'Shaba_number', 'balance']
        read_only_fields = ['balance']


class WithdrawSerializer(serializers.Serializer):
    amount = serializers.DecimalField(max_digits=10, decimal_places=2)


class PaymentSerializer(serializers.ModelSerializer):
    created_at = serializers.DateTimeField(format="%Y-%m-%d %H:%M:%S")

    class Meta:
        model = Payment
        fields = ['amount', 'track_id', 'order_id', 'created_at', 'verified']