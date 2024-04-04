# Generated by Django 5.0.3 on 2024-04-02 00:00

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account_module', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='address',
            name='user',
            field=models.OneToOneField(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='addresses', to=settings.AUTH_USER_MODEL),
        ),
    ]