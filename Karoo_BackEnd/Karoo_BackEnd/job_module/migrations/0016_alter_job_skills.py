# Generated by Django 5.0.4 on 2024-04-12 11:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('job_module', '0015_rename_experience_job_experiences'),
    ]

    operations = [
        migrations.AlterField(
            model_name='job',
            name='skills',
            field=models.ManyToManyField(blank=True, related_name='jobs', to='job_module.skill'),
        ),
    ]
