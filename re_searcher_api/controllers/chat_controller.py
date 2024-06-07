chat_controller = Namespace("api")

from flask_restx import Resource, Namespace

from core.authentication import authenticate
from service.knowledge_base.knowledge_base_service import get_knowledge_response

@chat_controller.route("/chat")
@authenticate
class AiResponseController(Resource):
    def post(self):
        try:
            user_messages = knowledge_base_api.payload
            response = get_knowledge_response(user_messages)
            return response, 201
        except Exception as e:
            print(traceback.format_exc())
            return {"error": str(e)}, 500

    def get(self):
        try:
            response = 1
            return response, 201
        except Exception as e:
            print(traceback.format_exc())
            return {"error": str(e)}, 500
