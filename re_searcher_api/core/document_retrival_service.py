import boto3

from consts import knowledge_base_id, aws_access_key_id, aws_secret_access_key

session = boto3.Session(
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
)

knowledge_base_client = session.client(service_name="bedrock-agent-runtime")


def get_document_citations(user_message, document_file_name):
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


def format_document_text(text):
    # TODO: Vuk
    return text
