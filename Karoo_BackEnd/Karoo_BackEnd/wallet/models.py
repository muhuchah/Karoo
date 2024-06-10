from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class Wallet(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    Shaba_number = models.CharField(max_length=26, unique=True, null=False, blank=False)
    balance = models.DecimalField(default=0.0, max_digits=10, decimal_places=2)

    def __str__(self):
        return f'User: {self.user}, Balance: {self.balance}'


class Payment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    amount = models.PositiveIntegerField()
    track_id = models.CharField(max_length=128)
    order_id = models.CharField(max_length=128, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    verified = models.BooleanField(default=False)