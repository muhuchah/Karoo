from django.utils import timezone

def deactivate_account(user, re_register_after_day=30):
    user.is_active = False
    user.can_re_register = True
    # user.re_register_at = timezone.now() + timezone.timedelta(days=re_register_after_day)
    user.re_register_at = timezone.now() + timezone.timedelta(seconds=10)
    user.save()