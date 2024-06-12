import traceback

from flask_restx import Resource, Namespace

test_controller_api = Namespace("api")


@test_controller_api.route("/test")
class TestController(Resource):
    def get(self):
        try:
            response = "Test success!"
            return response, 201
        except Exception as e:
            print(traceback.format_exc())
            return {"error": str(e)}, 500
