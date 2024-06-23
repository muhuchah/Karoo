from django.test import TestCase
import pytest
from django.core.files.uploadedfile import SimpleUploadedFile
from .models import MainCategory, SubCategory


class MainCategoryModelTest(TestCase):

    def setUp(self):
        self.image = SimpleUploadedFile(
            name='test_image.jpg',
            content=b'',
            content_type='image/jpeg'
        )
        self.category = MainCategory.objects.create(
            title="Test Category",
            description="This is a test category.",
            image=self.image
        )

    def test_string_representation(self):
        self.assertEqual(str(self.category), "Test Category")

    def test_unique_title(self):
        with self.assertRaises(Exception):
            MainCategory.objects.create(
                title="Test Category",  # Same title as the one in setUp
                description="This should fail.",
                image=self.image
            )

    def test_fields(self):
        category = MainCategory.objects.get(id=self.category.id)
        self.assertEqual(category.title, "Test Category")
        self.assertEqual(category.description, "This is a test category.")
        self.assertTrue(category.image.name.startswith('images/categories_images/test_image'))

    def test_blank_and_null_description(self):
        category_with_blank_description = MainCategory.objects.create(
            title="Blank Description Category",
            description="",
            image=self.image
        )
        self.assertEqual(category_with_blank_description.description, "")

        category_with_null_description = MainCategory.objects.create(
            title="Null Description Category",
            description=None,
            image=self.image
        )
        self.assertIsNone(category_with_null_description.description)


class SubCategoryModelTest(TestCase):

    def setUp(self):
        # Create a SimpleUploadedFile for the image field
        self.main_image = SimpleUploadedFile(
            name='main_test_image.jpg',
            content=b'',
            content_type='image/jpeg'
        )
        self.sub_image = SimpleUploadedFile(
            name='sub_test_image.jpg',
            content=b'',
            content_type='image/jpeg'
        )

        # Create a MainCategory instance for testing
        self.main_category = MainCategory.objects.create(
            title="Main Test Category",
            description="This is a main test category.",
            image=self.main_image
        )

        # Create a SubCategory instance for testing
        self.sub_category = SubCategory.objects.create(
            title="Sub Test Category",
            description="This is a sub test category.",
            image=self.sub_image,
            MainCategory=self.main_category
        )

    def test_string_representation(self):
        self.assertEqual(str(self.sub_category), "Sub Test Category")

    def test_unique_title(self):
        with self.assertRaises(Exception):
            SubCategory.objects.create(
                title="Sub Test Category",  # Same title as the one in setUp
                description="This should fail.",
                image=self.sub_image,
                MainCategory=self.main_category
            )

    def test_fields(self):
        sub_category = SubCategory.objects.get(id=self.sub_category.id)
        self.assertEqual(sub_category.title, "Sub Test Category")
        self.assertEqual(sub_category.description, "This is a sub test category.")
        self.assertTrue(sub_category.image.name.startswith('images/subcategories_images/sub_test_image'))
        self.assertEqual(sub_category.MainCategory, self.main_category)

    def test_blank_and_null_description(self):
        sub_category_with_blank_description = SubCategory.objects.create(
            title="Blank Description SubCategory",
            description="",
            MainCategory=self.main_category
        )
        self.assertEqual(sub_category_with_blank_description.description, "")

        sub_category_with_null_description = SubCategory.objects.create(
            title="Null Description SubCategory",
            description=None,
            MainCategory=self.main_category
        )
        self.assertIsNone(sub_category_with_null_description.description)

    def test_null_image(self):
        sub_category_with_null_image = SubCategory.objects.create(
            title="No Image SubCategory",
            description="This subcategory has no image.",
            image=None,
            MainCategory=self.main_category
        )
        self.assertEqual(sub_category_with_null_image.image.name, None)

    def test_foreign_key_null(self):
        sub_category_with_null_main_category = SubCategory.objects.create(
            title="Null MainCategory SubCategory",
            description="This subcategory has a null main category.",
            image=self.sub_image,
            MainCategory=None
        )
        self.assertIsNone(sub_category_with_null_main_category.MainCategory)