from django.test import TestCase
from account_module.models import User
from .models import Wallet
from model_bakery import baker


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
