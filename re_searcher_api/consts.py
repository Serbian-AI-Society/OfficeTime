from dotenv import load_dotenv

"""
file: consts.py
description: global constants
"""
import os

load_dotenv("./.env")

# Password passed as a token necessary for all API calls
api_password = "OfficeTimePassword"

# OPENAI API
openai_api_key = os.getenv("OPENAI_API_KEY")

use_aws_knowledge_base = False
use_pinecone = True

# [Optional] AWS + Knowledge Base
knowledge_base_id = os.getenv("AWS_KNOWLEDGE_BASE_ID")
aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")

pinecone_api = os.getenv("PINECONE_API")
pinecone_index_name = "researcher"

openai_embeddings_model = "text-embedding-3-small"
openai_chat_model = "gpt-3.5-turbo"
openai_completions_model = "gpt-3.5-turbo-instruct"

embeddings_chunk_size = 250
embeddings_overlap_size = 25
chat_max_tokens = 300
suggestions_max_tokes = 150
citations_number = 3
