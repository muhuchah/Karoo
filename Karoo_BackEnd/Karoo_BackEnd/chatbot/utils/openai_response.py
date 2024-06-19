from chatbot.utils.utils import retry_on_exeption, load_openai_config
from openai import OpenAI


@retry_on_exeption(retries=3, delay=1)
def openai_response(usermessage, sys_prompt, data):
    api_key, base_url = load_openai_config()
    client = OpenAI(api_key=api_key, base_url=base_url)

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