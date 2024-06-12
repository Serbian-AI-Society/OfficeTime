import uuid

from client import pinecone_index


def upsert_pinecone_vectors(vectors, filename, topics):
    batch_size = 100
    # Initialize an empty list to hold the batch
    batch = []

    for vector in vectors:
        # Append each vector along with its metadata to the batch list
        batch.append(
            {
                "id": str(uuid.uuid4()),  # Ensure UUID is a string
                "values": vector,
                "metadata": {"filename": filename, "topics": topics}
            }
        )

        # If the batch size limit is reached, upsert the batch and reset the list
        if len(batch) >= batch_size:
            pinecone_index.upsert(vectors=batch, namespace="researcher")
            batch.clear()

    # Upsert any remaining vectors in the last batch
    if batch:
        pinecone_index.upsert(vectors=batch, namespace="researcher")
