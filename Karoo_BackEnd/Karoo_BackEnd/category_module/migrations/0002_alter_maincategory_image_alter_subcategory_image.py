# Generated by Django 4.0.2 on 2024-03-25 23:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('category_module', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='maincategory',
            name='image',
            field=models.ImageField(upload_to='images/categories_images'),
        ),
        migrations.AlterField(
            model_name='subcategory',
            name='image',
            field=models.ImageField(upload_to='images/subcategories_images'),
        ),
    ]
