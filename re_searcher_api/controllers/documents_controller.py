import traceback

from flask_restx import Resource, Namespace

from core.authentication import authenticate
from services.documents.douments_service import upload_document_to_pinecone, get_citations_from_pinecone

documents_controller_api = Namespace("api")


@documents_controller_api.route("/documents")
@authenticate
class AiResponseController(Resource):
    def post(self):
        try:
            upload_document_to_pinecone()
            return 123, 201
        except Exception as e:
            print(traceback.format_exc())
            return {"error": str(e)}, 500

    def get(self):
        try:
            return get_citations_from_pinecone(), 201
        except Exception as e:
            print(traceback.format_exc())
            return {"error": str(e)}, 500
