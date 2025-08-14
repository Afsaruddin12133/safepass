import os

class Config:
    SECRET_KEY = "e3c1a9b8d8c34a5c9e2f14b3d7f1a9c6e4b0a9f7c1d3e8b4"

    MYSQL_HOST = "127.0.0.1"
    MYSQL_USER = "root"
    MYSQL_PASSWORD = ""
    MYSQL_DB = "user_db"
    MYSQL_CURSORCLASS = "DictCursor"

    JWT_SECRET_KEY = os.environ.get("JWT_SECRET_KEY", SECRET_KEY)
