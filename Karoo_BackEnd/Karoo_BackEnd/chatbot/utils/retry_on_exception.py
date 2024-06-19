from functools import wraps
import time

def retry_on_exeption(retries=3, delay=1):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            ex = True
            attempt = 0
            while ex and attempt < retries:
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    attempt += 1
                    if attempt < retries:
                        time.sleep(delay)
                    else:
                        raise e
        
        return wrapper
    return decorator
