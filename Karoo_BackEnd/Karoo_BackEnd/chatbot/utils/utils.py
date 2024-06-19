from functools import wraps
from dotenv import load_dotenv
import os
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


def load_openai_config():
    load_dotenv()
    api_key = os.getenv("API_KEY")
    base_url = os.getenv("BASE_URL")
    return api_key, base_url