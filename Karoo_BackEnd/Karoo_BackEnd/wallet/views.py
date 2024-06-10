from django.shortcuts import render
from django.views import View
from django.http import JsonResponse, HttpResponse
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status

from .models import Wallet
from .serializers import WalletSerializer, WithdrawSerializer


class WalletAPIView(APIView):
    def post(self, request):
        user = request.user
        shaba_number = request.data.get('Shaba_number')

        if not shaba_number:
            return Response({"error": "Shaba number is required"}, status=status.HTTP_400_BAD_REQUEST)

        wallet, created = Wallet.objects.get_or_create(user=user, defaults={'Shaba_number': shaba_number})

        if not created:
            wallet.Shaba_number = shaba_number
            wallet.save()
            return Response({"message": "Shaba number updated successfully"}, status=status.HTTP_200_OK)

        return Response({"message": "Wallet created successfully"}, status=status.HTTP_201_CREATED)

    
    def get(self, request):
        try:
            wallet = Wallet.objects.get(user=request.user)
        except Wallet.DoesNotExist:
            return Response(
                {"detail": "Wallet not found."},
                status=status.HTTP_404_NOT_FOUND
            )

        serializer = WalletSerializer(wallet)
        return Response(serializer.data, status=status.HTTP_200_OK)


class WalletWithdrawView(APIView):
    def post(self, request):
        serializer = WithdrawSerializer(data=request.data)
        if serializer.is_valid():
            amount = serializer.validated_data['amount']
            try:
                wallet = Wallet.objects.get(user=request.user)
            except Wallet.DoesNotExist:
                return Response(
                    {"detail": "Wallet not found."},
                    status=status.HTTP_404_NOT_FOUND
                )

            if wallet.balance < amount:
                return Response(
                    {"detail": "Insufficient balance."},
                    status=status.HTTP_400_BAD_REQUEST
                )

            wallet.balance -= amount
            wallet.save()

            return Response(
                {"detail": "Withdrawal successful.", "new_balance": wallet.balance},
                status=status.HTTP_200_OK
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)