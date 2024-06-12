import traceback

from flask_restx import Resource, Namespace

from core.authentication import authenticate

documents_controller_api = Namespace("api")


@documents_controller_api.route("/documents")
@authenticate
class AiResponseController(Resource):
    def post(self):
        try:

            return 123, 201
        except Exception as e:
            print(traceback.format_exc())
            return {"error": str(e)}, 500
