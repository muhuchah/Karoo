from weakref import proxy
from django.test import TestCase
from django.utils import timezone
from support.models import SpamReport
from job_module.models import job, skill
from account_module.models import User, Province, City
from category_module.models import MainCategory, SubCategory
from model_bakery import baker

class SpamReportModelTest(TestCase):
    def setUp(self):
        self.user = baker.make(
            User, 
            email='testuser@example.com', 
            is_active=True
        )

        self.main_category = baker.make(MainCategory)
        self.sub_category = baker.make(SubCategory, MainCategory=self.main_category)

        self.province = baker.make(Province)
        self.city = baker.make(City, province=self.province)

        self.job = baker.make(
            job,
            user = self.user,
            SubCategory = self.sub_category,
            province = self.province,
            city = self.city
        )

        self.skills = baker.make(skill, _quantity=3)
        self.job.skills.add(*self.skills)

        # Create a SpamReport instance
        self.spam_report = SpamReport.objects.create(
            user=self.user,
            job=self.job,
            message='This is a spam report message'
        )

    def test_spam_report_creation(self):
        # Test that the SpamReport instance was created correctly
        self.assertIsInstance(self.spam_report, SpamReport)
        self.assertEqual(self.spam_report.user, self.user)
        self.assertEqual(self.spam_report.job, self.job)
        self.assertEqual(self.spam_report.message, 'This is a spam report message')
        self.assertTrue(self.spam_report.reported_at <= timezone.now())

    def test_spam_report_str_method(self):
        # Test the __str__ method of the SpamReport model
        expected_str = f"Spam report for job ID: {self.job.id} ({self.spam_report.reported_at})"
        self.assertEqual(str(self.spam_report), expected_str)
