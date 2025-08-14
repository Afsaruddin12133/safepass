from extensions import mysql

def get_user_by_email(email):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
    user = cursor.fetchone()
    cursor.close()
    return user

def create_user(email, password_hash):
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO users (email, password) VALUES (%s, %s)", (email, password_hash))
    mysql.connection.commit()
    cursor.close()
