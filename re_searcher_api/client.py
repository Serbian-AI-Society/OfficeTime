import boto3
from openai import OpenAI
from pinecone import Pinecone

from consts import openai_api_key, aws_access_key_id, aws_secret_access_key, pinecone_api, pinecone_index_name

openai_client = OpenAI(
    api_key=openai_api_key
)

pc = Pinecone(api_key=pinecone_api)
pinecone_index = pc.Index(pinecone_index_name)

boto3_session = boto3.Session(
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
)

knowledge_base_client = boto3_session.client(service_name="bedrock-agent-runtime", region_name="us-east-1")
