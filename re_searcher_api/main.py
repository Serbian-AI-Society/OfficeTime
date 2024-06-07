from flask import Flask


app = Flask(__name__)

api = Api(app)
api.add_namespace(knowledge_base_api, path='/api')

# main driver function
if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
