from services.documents.embeddings_service import separate_text_from_pdf, chunk_text, get_embeddings_for_chunks
from services.documents.pinecone_service import upsert_pinecone_vectors


def upload_document_to_pinecone():
    filename = "test_cats.pdf"
    topics = ["cats", "animals"]

    document_text = separate_text_from_pdf()
    chunks = chunk_text(document_text)
    embeddings = get_embeddings_for_chunks(chunks)
    upsert_pinecone_vectors(embeddings, filename, topics)


def get_citations_from_pinecone(user_message, filename):
    user_message = "What are cats?"
    return []
