from django.test import TestCase
import pytest
from django.core.files.uploadedfile import SimpleUploadedFile
from .models import MainCategory, SubCategory

@pytest.mark.django_db
def test_create_main_category():
    main_category = MainCategory.objects.create(
        title='Main Category 1',
        description='Description for Main Category 1',
        image=SimpleUploadedFile(name='test_image.jpg', content=b'', content_type='image/jpeg')
    )
    
    assert main_category.title == 'Main Category 1'
    assert main_category.description == 'Description for Main Category 1'
    assert main_category.image.name.startswith('images/categories_images/test_image')

@pytest.mark.django_db
def test_main_category_str():
    main_category = MainCategory.objects.create(
        title='Main Category 1',
        description='Description for Main Category 1',
        image=SimpleUploadedFile(name='test_image.jpg', content=b'', content_type='image/jpeg')
    )
    
    assert str(main_category) == 'Main Category 1'

@pytest.mark.django_db
def test_create_sub_category():
    main_category = MainCategory.objects.create(
        title='Main Category 1',
        description='Description for Main Category 1',
        image=SimpleUploadedFile(name='test_image.jpg', content=b'', content_type='image/jpeg')
    )
    
    sub_category = SubCategory.objects.create(
        title='Sub Category 1',
        description='Description for Sub Category 1',
        image=SimpleUploadedFile(name='test_image.jpg', content=b'', content_type='image/jpeg'),
        MainCategory=main_category
    )
    
    assert sub_category.title == 'Sub Category 1'
    assert sub_category.description == 'Description for Sub Category 1'
    assert sub_category.image.name.startswith('images/subcategories_images/test_image')
    assert sub_category.MainCategory == main_category

@pytest.mark.django_db
def test_sub_category_str():
    main_category = MainCategory.objects.create(
        title='Main Category 1',
        description='Description for Main Category 1',
        image=SimpleUploadedFile(name='test_image.jpg', content=b'', content_type='image/jpeg')
    )
    
    sub_category = SubCategory.objects.create(
        title='Sub Category 1',
        description='Description for Sub Category 1',
        image=SimpleUploadedFile(name='test_image.jpg', content=b'', content_type='image/jpeg'),
        MainCategory=main_category
    )
    
    assert str(sub_category) == 'Sub Category 1'
