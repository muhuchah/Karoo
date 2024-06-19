from chatbot.utils.utils import retry_on_exeption, load_openai_config
from openai import OpenAI


@retry_on_exeption(retries=3, delay=1)
def create_embedding(data):
    api_key, base_url = load_openai_config()
    client = OpenAI(api_key=api_key, base_url=base_url)

    response = client.embeddings.create(
        input = data,
        model = 'text-embedding-ada-002',
        encoding_format = 'float'
    )
    return response.data[0].embedding