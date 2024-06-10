from django.contrib.auth import get_user_model
from rest_framework import serializers
from .models import Wallet

User = get_user_model()


class WalletSerializer(serializers.ModelSerializer):
    class Meta:
        model = Wallet
        fields = ['user', 'Shaba_number', 'balance']
        read_only_fields = ['balance']


class WithdrawSerializer(serializers.Serializer):
    amount = serializers.DecimalField(max_digits=10, decimal_places=2)