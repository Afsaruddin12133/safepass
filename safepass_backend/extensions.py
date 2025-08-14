from flask_jwt_extended import JWTManager
from flask_mysqldb import MySQL

# Handles DB connection & Queries...
mysql = MySQL()

# Handles JSON Web Token Authentication...
jwt = JWTManager()
