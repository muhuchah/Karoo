# Generated by Django 4.0.2 on 2024-03-25 23:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('job_module', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='job',
            name='image',
        ),
        migrations.CreateModel(
            name='job_pictures',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(blank=True, null=True, upload_to='images/job_images')),
                ('job', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='pictures', to='job_module.job')),
            ],
        ),
    ]
