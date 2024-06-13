import pymupdf

from client import openai_client
from consts import openai_embeddings_model, embeddings_chunk_size, embeddings_overlap_size


# Function to chunk text
def chunk_text(text, chunk_size=embeddings_chunk_size, overlap=embeddings_overlap_size):
    words = text.split()
    chunks = []
    for i in range(0, len(words), chunk_size - overlap):
        chunk = " ".join(words[i:i + chunk_size])
        chunks.append(chunk)
    return chunks


# Function to get embeddings for text chunks
def get_embeddings_for_chunks(chunks):
    embeddings = []
    for chunk in chunks:
        embedding = get_embeddings(chunk)
        embeddings.append(embedding)
    return embeddings


def get_embeddings(text):
    text = text.replace("\n", " ")
    return openai_client.embeddings.create(input=[text], model=openai_embeddings_model).data[0].embedding


def separate_text_from_pdf(file):
    # Read the PDF file from bytes
    pdf_bytes = file.read()

    # Open the PDF from bytes
    pdf_document = pymupdf.open(stream=pdf_bytes, filetype="pdf")

    # Extract text from all pages
    text = ""
    for page_num in range(pdf_document.page_count):
        page = pdf_document.load_page(page_num)
        text += page.get_text() + "\n\n"

    return text
