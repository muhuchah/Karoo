from openai import OpenAI
import jsonlines
import time
from functools import wraps


# Openai Variables
API_KEY = ""
BASE_URL = ""


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


@retry_on_exeption(retries=3, delay=1)
def openai_response(usermessage, sys_prompt, data):
    client = OpenAI(api_key=API_KEY, base_url=BASE_URL)

    if "{data}" in sys_prompt:
        content = sys_prompt.format(data=data)
    else:
        content = sys_prompt
    usermessage += "\nSTRICTLY Do not give me any information about anything that is not mentioned in the PROVIDED CONTEXT."

    completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": content},
            {"role": "user", "content": usermessage}
        ]
    )
    return completion.choices[0].message.content


@retry_on_exeption(retries=3, delay=1)
def openai_generate_title(user_message):
    client = OpenAI(api_key=API_KEY, base_url=BASE_URL)

    completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a chatbot, skilled in answering user's questions, generate a good and small (under 16 characters) title for the user message"},
            {"role": "user", "content": user_message}
        ]
    )
    return completion.choices[0].message.content


@retry_on_exeption(retries=3, delay=1)
def create_embedding(data):
    client = OpenAI(api_key=API_KEY, base_url=BASE_URL)

    response = client.embeddings.create(
        input = data,
        model = 'text-embedding-ada-002',
        encoding_format = 'float'
    )
    return response.data[0].embedding