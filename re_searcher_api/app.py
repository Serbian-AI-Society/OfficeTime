import traceback

from flask import Flask, request
from flask_cors import CORS
from flask_restx import Api

from controllers.chat_controller import chat_controller_api
from controllers.test_controller import test_controller_api
from services.documents.douments_service import upload_document_to_pinecone

app = Flask(__name__)
CORS(app)

api = Api(app)

# Add controller namespaces
api.add_namespace(test_controller_api)
api.add_namespace(chat_controller_api)


@app.route('/api/documents', methods=['POST'])
def index():
    try:
        # upload_document_to_pinecone()
        name = request.form["name"]
        description = request.form["description"]
        topic = request.form["topic"]
        file = request.files["file"]

        return upload_document_to_pinecone(file, topic, name, description), 201
    except Exception as e:
        print(traceback.format_exc())
        return {"error": str(e)}, 500


if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
