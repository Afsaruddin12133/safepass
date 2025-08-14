from werkzeug.security import generate_password_hash, check_password_hash
from models.user import get_user_by_email, create_user
from flask_jwt_extended import create_access_token
from flask import Blueprint, request, jsonify

# Blueprint for authentication routes...
auth_bp = Blueprint("auth", __name__)
@auth_bp.route("/register", methods=["POST"])

# Create a New User with Email & Password...
def register():
    data = request.json or {}
    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"error": "Email and password are required"}), 400

    if get_user_by_email(email):
        return jsonify({"error": "Email already exists"}), 400

    hashed_pw = generate_password_hash(password)
    create_user(email, hashed_pw)

    return jsonify({"message": "User registered successfully"}), 201

# Login Existing User With Email & Password, Return JWT if Success...
@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.json or {}
    email = data.get("email")
    password = data.get("password")

    user = get_user_by_email(email)

    if not user or not check_password_hash(user["password"], password):
        return jsonify({"error": "Invalid email or password"}), 401

    token = create_access_token(identity=user["id"])

    # Return both token and email to Frontend...
    return jsonify({
        "access_token": token,
        "email": user["email"]
    }), 200

