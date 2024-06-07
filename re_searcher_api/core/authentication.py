import os

from flask import request

from consts import api_password


# Define your authentication decorator for class-based views
# Required Request header 'Token' with the password value
def authenticate(cls):
    class DecoratedClass(cls):
        def dispatch_request(self, *args, **kwargs):
            if os.getenv("REQUIRE_PASSWORD") == 'false':
                return super().dispatch_request(*args, **kwargs)

            if 'Token' not in request.headers:
                return "Missing or incorrect password.", 401

            expected_token = api_password
            provided_token = request.headers.get('Token')

            if provided_token != expected_token:
                return "Missing or incorrect password.", 401

            return super().dispatch_request(*args, **kwargs)

    return DecoratedClass
