from flask import Flask
from flask_cors import CORS
from flask_restx import Api

from controllers.chat_controller import chat_controller_api
from controllers.documents_controller import documents_controller_api
from controllers.test_controller import test_controller_api

app = Flask(__name__)
CORS(app)

api = Api(app)

# Add controller namespaces
api.add_namespace(test_controller_api)
api.add_namespace(chat_controller_api)
api.add_namespace(documents_controller_api)

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
