"""
file: document_retrival_service.py
description: response citations processing
"""

import re

from srtools import cyrillic_to_latin

from client import knowledge_base_client
from consts import knowledge_base_id
from core.deprecated_decorator import deprecated

"""
name: get_document_citations
params: user_message, document_file_name
description: returns the citations array with formatted text from response body JSON
"""


@deprecated
def get_document_citations_from_aws(user_message, document_file_name):
    citations = []

    response = knowledge_base_client.retrieve(
        knowledgeBaseId=knowledge_base_id,
        retrievalQuery={
            'text': user_message
        },
        retrievalConfiguration={
            'vectorSearchConfiguration': {
                'numberOfResults': 10,
                # 'overrideSearchType': "HYBRID",
            }
        }
    )

    for retrievedResult in response["retrievalResults"]:
        if document_file_name in retrievedResult["location"]["s3Location"]["uri"]:
            citations.append(format_document_text(retrievedResult['content']['text']))

    return citations


"""
name: format_document_text
params: text sentence
response: returns a formatted sentence so the content fed to the OpenAI API is uniform
"""


@deprecated
def format_document_text(text):
    t_sentence = ""
    # In case cyrillic alphabet is used, convert it to latin
    if re.search('[\u0400-\u04FF]', text):
        t_sentence = cyrillic_to_latin(text)
    return t_sentence
