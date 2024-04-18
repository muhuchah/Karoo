from django.core.management import call_command

def db_backup():
    try:
        call_command('dbbackup')
    except Exception as e:
        raise CommandError(f"Database backup failed: {e}") from e