from openai import OpenAI
from consts import openai_api_key, aws_access_key_id, aws_secret_access_key
import boto3

openai_client = OpenAI(
    api_key=openai_api_key
)

boto3_session = boto3.Session(
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
)

knowledge_base_client = boto3_session.client(service_name="bedrock-agent-runtime", region_name="us-east-1")
