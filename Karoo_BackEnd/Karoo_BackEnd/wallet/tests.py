from django.test import TestCase
from account_module.models import User
from .models import Wallet, Payment
from model_bakery import baker
from rest_framework import status
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import AccessToken
from .serializers import PaymentSerializer


class WalletModelTest(TestCase):
    def setUp(self):
        self.user = baker.make(
            User, 
            email='testuser@example.com', 
            is_active=True
        )
        self.wallet = Wallet.objects.create(
            user=self.user, 
            Shaba_number='IR01234567890123456789012345'
        )

    def test_wallet_creation(self):
        wallet = Wallet.objects.get(user=self.user)
        self.assertEqual(wallet.Shaba_number, 'IR01234567890123456789012345')
        self.assertEqual(wallet.balance, 0.0)

    def test_wallet_string_representation(self):
        wallet = Wallet.objects.get(user=self.user)
        self.assertEqual(str(wallet), f'User: {self.user}, Balance: 0.00')

    def test_wallet_balance_default_value(self):
        wallet = Wallet.objects.get(user=self.user)
        self.assertEqual(wallet.balance, 0.0)

    def test_unique_shaba_number(self):
        with self.assertRaises(Exception):
            Wallet.objects.create(user=self.user, Shaba_number='IR01234567890123456789012345')


class PaymentModelTest(TestCase):
    def setUp(self):
        self.user = baker.make(
            User, 
            email='testuser@example.com', 
            is_active=True
        )
        self.payment = Payment.objects.create(
            user=self.user,
            amount=100,
            track_id='track123',
            order_id='order123'
        )

    def test_payment_creation(self):
        payment = Payment.objects.get(order_id='order123')
        self.assertEqual(payment.user, self.user)
        self.assertEqual(payment.amount, 100)
        self.assertEqual(payment.track_id, 'track123')
        self.assertEqual(payment.order_id, 'order123')
        self.assertFalse(payment.verified)

    def test_payment_verified_default_value(self):
        payment = Payment.objects.get(order_id='order123')
        self.assertFalse(payment.verified)

    def test_unique_order_id(self):
        with self.assertRaises(Exception):
            Payment.objects.create(
                user=self.user,
                amount=200,
                track_id='track456',
                order_id='order123'
            )

    def test_auto_now_add_created_at(self):
        payment = Payment.objects.get(order_id='order123')
        self.assertIsNotNone(payment.created_at)


class UserPaymentHistoryTest(TestCase):

    def setUp(self):
        self.user = baker.make(
            User, 
            email='testuser@example.com', 
            is_active=True
        )
        self.client = APIClient()
        self.access_token = str(AccessToken.for_user(self.user))

        self.payment1 = Payment.objects.create(
            user=self.user,
            amount=100,
            track_id='track123',
            order_id='order123'
        )

        self.payment2 = Payment.objects.create(
            user=self.user,
            amount=200,
            track_id='track456',
            order_id='order456'
        )

    def test_user_payment_history(self):
        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {self.access_token}')
        response = self.client.get('http://127.0.0.1:8000/wallet/payment_history/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        payments = Payment.objects.filter(user=self.user)
        serializer = PaymentSerializer(payments, many=True)
        self.assertEqual(response.data, serializer.data)