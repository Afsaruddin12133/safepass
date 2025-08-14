from extensions import mysql, jwt
from routes.auth_routes import auth_bp
from flask_cors import CORS
from config import Config
from flask import Flask


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Allow CORS for all routes...
    CORS(app, resources={r"/*": {"origins": "*"}})

    # Init MySql & JWT extensions...
    mysql.init_app(app)
    jwt.init_app(app)

    # Root Route...
    @app.route('/')
    def home():
        return "Welcome to the Safepass Backend! Whoo! It's Running...."

    # Register the Authentication Routes...
    app.register_blueprint(auth_bp, url_prefix="/auth")

    return app

if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)
