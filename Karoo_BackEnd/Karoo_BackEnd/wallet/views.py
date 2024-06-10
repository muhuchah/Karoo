from django.shortcuts import render
from django.views import View
from django.http import JsonResponse, HttpResponse
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
import json
import requests
import time
from django.http import JsonResponse


from .models import Wallet, Payment
from .serializers import WalletSerializer, WithdrawSerializer


merchant = 'zibal'
callbackUrl = 'http://127.0.0.1:8000/wallet/zibal/verify/'
description = 'Karoo'
mobile = '09152859657'

ZIBAL_API_REQUEST = "https://gateway.zibal.ir/v1/request"
ZIBAL_API_VERIFY = "https://gateway.zibal.ir/v1/verify"
ZIBAL_API_STARTPAY = "https://gateway.zibal.ir/start/"


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


class PayView(APIView):
    def post(self, request):
        amount = request.data.get('amount')
        
        if not amount:
            return Response(
                {"error": "amount is required"},
                status=status.HTTP_400_BAD_REQUEST
            )

        user = request.user
        order_id = f"ZBL-{user.id}-{int(time.time())}"

        data = {
            "merchant": merchant,
            "amount": amount,
            "callbackUrl": callbackUrl,
            "description": description,
            "orderId": order_id,
            "mobile": mobile
        }
        data = json.dumps(data)
        headers = {'content-type': 'application/json', 'content-length': str(len(data))}
        
        try:
            response = requests.post(ZIBAL_API_REQUEST, data=data, headers=headers, timeout=10)

            if response.status_code == 200:
                response = response.json()
                if response['result'] == 100:
                    track_id = response['trackId']
                    print(f"trackId: {track_id}")
                    startpay_url = ZIBAL_API_STARTPAY + str(track_id)

                    Payment.objects.create (
                        user=user,
                        amount=amount,
                        track_id=track_id,
                        order_id=order_id
                    )

                    return JsonResponse({'startpay_url': startpay_url})
                else:
                    return JsonResponse({'status': False, 'message': 'Payment initiation failed.', 'details': response})

            return Response(response, status=status.HTTP_400_BAD_REQUEST)

        except requests.exceptions.Timeout:
            return Response({'status': 'False', 'code': 'timeout'}, status=status.HTTP_504_GATEWAY_TIMEOUT)
        except requests.exceptions.ConnectionError:
            return Response({'status': 'False', 'code': 'ConnectionError'}, status=status.HTTP_503_SERVICE_UNAVAILABLE)


class VerifyPayView(APIView):
    def get(self, request):
        success = request.GET.get('success')
        track_id = request.GET.get('trackId')
        order_id = request.GET.get('orderId')
        payment_status = request.GET.get('status')

        if success == '1' and track_id:
            verify_data = json.dumps({"merchant": merchant, "trackId": track_id})
            headers = {'content-type': 'application/json', 'content-length': str(len(verify_data))}
            
            try:
                response = requests.post(ZIBAL_API_VERIFY, data=verify_data, headers=headers, timeout=10)
                if response.status_code == 200:
                    response = response.json()
                    if response['result'] == 100:
                        try:
                            payment = Payment.objects.get(track_id=track_id, verified=False)
                            payment.verified = True
                            payment.save()

                            wallet = Wallet.objects.get(user=payment.user)
                            wallet.balance += payment.amount
                            wallet.save()

                            return Response({
                                'status': True,
                                'message': 'Payment verified successfully.',
                                'new_balance': wallet.balance,
                                'details': response
                            }, status=status.HTTP_200_OK)
                        except Payment.DoesNotExist:
                            return Response(
                                {"status": False, "message": "Payment not found or already verified."},
                                status=status.HTTP_404_NOT_FOUND
                            )
                        except Wallet.DoesNotExist:
                            return Response(
                                {"status": False, "message": "Wallet not found."},
                                status=status.HTTP_404_NOT_FOUND
                            )

                        return Response({
                            'status': True,
                            'message': 'Payment verified successfully.',
                            'new_balance': wallet.balance,
                            'details': response
                        }, status=status.HTTP_200_OK)
                    else:
                        return JsonResponse({
                            'status': False,
                            'message': 'Payment verification failed.',
                            'details': response
                        }, status=status.HTTP_400_BAD_REQUEST)

                return Response(response, status=status.HTTP_400_BAD_REQUEST)
            except requests.exceptions.Timeout:
                return Response({'status': False, 'code': 'timeout'}, status=status.HTTP_504_GATEWAY_TIMEOUT)
            except requests.exceptions.ConnectionError:
                return Response({'status': False, 'code': 'ConnectionError'}, status=status.HTTP_503_SERVICE_UNAVAILABLE)
        else:
            return JsonResponse({'status': False, 'message': 'Payment not successful or invalid trackId.'}, status=status.HTTP_400_BAD_REQUEST)


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