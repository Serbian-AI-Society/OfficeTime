"""
file: consts.py
description: global constants
"""
import os

# OPENAI API
openai_api_key = os.getenv("OPENAI_API_KEY")

# Password passed as a token necessary for all API calls
api_password = "OfficeTimePassword"

# [Optional] AWS + Knowledge Base
knowledge_base_id = os.environ.get("AWS_KNOWLEDGE_BASE_ID")
aws_access_key_id = os.environ.get("AWS_ACCESS_KEY_ID")
aws_secret_access_key = os.environ.get("AWS_SECRET_ACCESS_KEY")
