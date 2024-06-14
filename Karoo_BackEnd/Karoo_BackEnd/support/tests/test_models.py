from weakref import proxy
from django.test import TestCase
from django.utils import timezone
from support.models import SpamReport, Message
from job_module.models import job, skill
from account_module.models import User, Province, City
from category_module.models import MainCategory, SubCategory
from model_bakery import baker
import time
from datetime import datetime, timedelta


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

        self.job = job.objects.create(
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


class MessageModelTest(TestCase):

    def setUp(self):
        self.sender = baker.make(
            User, 
            email='testuser@example.com', 
            is_active=True
        )
        self.recipient = baker.make(
            User, 
            email='testuser2@example.com', 
            is_active=True
        )
        self.message1 = Message.objects.create(
            sender=self.sender,
            recipient=self.recipient,
            content='Hello, how are you?',
            timestamp=datetime.now()
        )
        time.sleep(0.5)
        self.message2 = Message.objects.create(
            sender=self.sender,
            recipient=self.recipient,
            content='I am fine, thank you!',
            timestamp=datetime.now() + timedelta(hours=1)
        )

    def test_message_creation(self):
        message_count = Message.objects.count()
        self.assertEqual(message_count, 2)

    def test_message_string_representation(self):
        message = Message.objects.first()
        expected_str = f"Message from {message.sender} to {message.recipient} ({message.timestamp})"
        self.assertEqual(str(message), expected_str)

    def test_message_ordering(self):
        messages = Message.objects.all()
        timestamps = [msg.timestamp for msg in messages]
        self.assertEqual(list(messages), list(messages.order_by('timestamp')))
        self.assertEqual(timestamps, sorted(timestamps))

    def tearDown(self):
        User.objects.all().delete()