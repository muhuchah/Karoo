from django.test import TestCase
from account_module.models import User
from django.core.files.uploadedfile import SimpleUploadedFile
from category_module.models import  MainCategory, SubCategory
from .models import job, job_pictures, Province, City, skill, TimeSlot, DailySchedule
from model_bakery import baker


class JobModelTest(TestCase):

    def setUp(self):
        # Create a User instance
        self.user = baker.make(
            User,
            email='testuser@example.com',
            is_active=True
        )

        # Create a Province instance
        self.province = Province.objects.create(name='Test Province')

        # Create a City instance
        self.city = City.objects.create(name='Test City', province=self.province)

        # Create a MainCategory instance
        self.main_image = SimpleUploadedFile(
            name='main_test_image.jpg',
            content=b'',
            content_type='image/jpeg'
        )
        self.main_category = MainCategory.objects.create(
            title="Main Test Category",
            description="This is a main test category.",
            image=self.main_image
        )

        # Create a SubCategory instance
        self.sub_image = SimpleUploadedFile(
            name='sub_test_image.jpg',
            content=b'',
            content_type='image/jpeg'
        )
        self.sub_category = SubCategory.objects.create(
            title="Sub Test Category",
            description="This is a sub test category.",
            image=self.sub_image,
            MainCategory=self.main_category
        )

        # Create a skill instance
        self.skill = skill.objects.create(title="Test Skill")

        # Create a Job instance
        self.job = job.objects.create(
            title="Test Job",
            description="This is a test job.",
            SubCategory=self.sub_category,
            user=self.user,
            province=self.province,
            city=self.city,
        )

        # Create a JobPictures instance
        self.job_image = SimpleUploadedFile(
            name='job_test_image.jpg',
            content=b'',
            content_type='image/jpeg'
        )
        self.job_pictures = job_pictures.objects.create(
            job=self.job,
            image=self.job_image
        )

        # Create TimeSlot instances
        self.time_slot1 = TimeSlot.objects.create(start_time="11:00:00", end_time="13:00:00")
        self.time_slot2 = TimeSlot.objects.create(start_time="14:00:00", end_time="15:00:00")

        # Create a DailySchedule instance
        self.daily_schedule = DailySchedule.objects.create(
            job=self.job,
            day_of_week='monday'
        )
        self.daily_schedule.time_slots.add(self.time_slot1, self.time_slot2)

        # Assign skills and timetable to the job
        self.job.skills.add(self.skill)
        self.job.timetable.add(self.daily_schedule)
        self.job.main_picture = self.job_pictures
        self.job.save()

    def test_string_representation_job(self):
        self.assertEqual(str(self.job), "Test Job")

    def test_string_representation_job_pictures(self):
        self.assertEqual(str(self.job_pictures), f'job title:{self.job.title}, user:{self.job.user.email}')

    def test_job_fields(self):
        job_instance = job.objects.get(id=self.job.id)
        self.assertEqual(job_instance.title, "Test Job")
        self.assertEqual(job_instance.description, "This is a test job.")
        self.assertEqual(job_instance.SubCategory, self.sub_category)
        self.assertEqual(job_instance.user, self.user)
        self.assertEqual(job_instance.province, self.province)
        self.assertEqual(job_instance.city, self.city)
        self.assertEqual(job_instance.main_picture, self.job_pictures)

    def test_job_picture_fields(self):
        job_pictures_instance = job_pictures.objects.get(id=self.job_pictures.id)
        self.assertEqual(job_pictures_instance.job, self.job)
        #self.assertTrue(job_pictures_instance.image.name.startswith('images/job_pictures/job_test_image'))

    def test_job_skills(self):
        self.assertIn(self.skill, self.job.skills.all())

    def test_job_timetable(self):
        self.assertIn(self.daily_schedule, self.job.timetable.all())

    def test_foreign_key_subcategory(self):
        job_instance = job.objects.get(id=self.job.id)
        self.assertEqual(job_instance.SubCategory, self.sub_category)

    def test_foreign_key_user(self):
        job_instance = job.objects.get(id=self.job.id)
        self.assertEqual(job_instance.user, self.user)

    def test_foreign_key_province(self):
        job_instance = job.objects.get(id=self.job.id)
        self.assertEqual(job_instance.province, self.province)

    def test_foreign_key_city(self):
        job_instance = job.objects.get(id=self.job.id)
        self.assertEqual(job_instance.city, self.city)

    def test_one_to_one_main_picture(self):
        job_instance = job.objects.get(id=self.job.id)
        self.assertEqual(job_instance.main_picture, self.job_pictures)
