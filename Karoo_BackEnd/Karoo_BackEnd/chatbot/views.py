from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.db.models import F
from pgvector.expressions import CosineSimilarity

from chatbot.utils.create_embedding import create_embedding
from chatbot.utils.openai_response import openai_response
from .models import JobEmbedding


def get_jobs_by_cosine_similarity(query_embedding, num_results=5):
    # query_embedding should be a list or numpy array representing the embedding of the query job
    
    # Perform cosine similarity search using pgvector
    similarity_query = JobEmbedding.objects.annotate(
        similarity=CosineSimilarity('embedding', query_embedding)
    ).order_by(F('similarity').desc())[:num_results]
    
    # Retrieve the jobs
    top_jobs = [item.job for item in similarity_query]
    
    return top_jobs


class OpenAIChatView(APIView):
    def post(self, request, format=None):
        user_message = request.data.get('user_message')
        if not user_message:
            return Response({'error': 'Missing required parameters'}, status=status.HTTP_400_BAD_REQUEST)
        user_message_embed = create_embedding(user_message)
        
        top_jobs = get_jobs_by_cosine_similarity(user_message_embed, num_results=3)
        data = ""
        for job in top_jobs:
            data += job.description
        system_prompt = ""
        chatbot_response = openai_response(usermessage=user_message, data=data, sys_prompt=system_prompt)

        try:
            chatbot_response = openai_response(usermessage=user_message, data=data, sys_prompt=system_prompt)
            return Response({'response': chatbot_response}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)