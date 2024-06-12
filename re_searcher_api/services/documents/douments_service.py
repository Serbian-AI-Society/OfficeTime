from services.documents.embeddings_service import separate_text_from_pdf, chunk_text, get_embeddings_for_chunks, \
    get_embeddings
from services.documents.pinecone_service import upsert_pinecone_vectors, query_pinecone_vectors


def upload_document_to_pinecone(file, topic, name, description):
    filename = file.filename
    topics = [topic]

    document_text = separate_text_from_pdf(file)
    chunks = chunk_text(document_text)
    embeddings = get_embeddings_for_chunks(chunks)
    upsert_pinecone_vectors(embeddings, chunks, filename, topics)
    return f"Success! [{name}]"


def get_citations_from_pinecone(user_message, filename, topic=None):
    user_message_embedding = get_embeddings(user_message)

    pinecone_results = query_pinecone_vectors(user_message_embedding, filename, topic)
    matches = pinecone_results['matches']

    sorted_matches = sorted(matches, key=lambda x: x['score'], reverse=True)
    content_list = [match['metadata']['content'] for match in sorted_matches]

    return content_list
