from flask import Flask

from flask_cors import CORS
from flask_restx import Api

from controllers.chat_controller import chat_controller_api

app = Flask(__name__)
CORS(app)

api = Api(app)
api.add_namespace(chat_controller_api, path='/api')

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
