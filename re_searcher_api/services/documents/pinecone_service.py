import uuid

from client import pinecone_index
from consts import pinecone_index_name, citations_number


def upsert_pinecone_vectors(vectors, chunks, filename, topics):
    batch_size = 100
    # Initialize an empty list to hold the batch
    batch = []

    for index, (vector, text_chunk) in enumerate(zip(vectors, chunks)):
        # Append each vector along with its metadata to the batch list
        batch.append(
            {
                "id": str(uuid.uuid4()),  # Ensure UUID is a string
                "values": vector,
                "metadata": {"filename": filename, "topics": topics, "content": text_chunk}
            }
        )

        # If the batch size limit is reached, upsert the batch and reset the list
        if len(batch) >= batch_size:
            pinecone_index.upsert(vectors=batch, namespace=pinecone_index_name)
            batch.clear()

    # Upsert any remaining vectors in the last batch
    if batch:
        pinecone_index.upsert(vectors=batch, namespace=pinecone_index_name)


def query_pinecone_vectors(query_vector, filename=None, topic=None):
    metadata = {}
    if filename is not None:
        metadata["filename"] = filename
    if topic is not None:
        metadata["topics"] = topic

    pinecone_result = pinecone_index.query(
        namespace=pinecone_index_name,
        vector=query_vector,
        top_k=citations_number,
        # filter=metadata,
        include_metadata=True,
        include_values=True
    )

    return pinecone_result.to_dict()
