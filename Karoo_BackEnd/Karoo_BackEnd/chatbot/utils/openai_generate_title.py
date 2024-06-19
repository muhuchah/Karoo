from chatbot.utils.utils import retry_on_exeption, load_openai_config
from openai import OpenAI


@retry_on_exeption(retries=3, delay=1)
def openai_generate_title(user_message):
    api_key, base_url = load_openai_config()
    client = OpenAI(api_key=api_key, base_url=base_url)

    completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a chatbot, skilled in answering user's questions, generate a good and small (under 16 characters) title for the user message"},
            {"role": "user", "content": user_message}
        ]
    )
    return completion.choices[0].message.content