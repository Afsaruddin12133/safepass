# **SafePass**

_A secure cross-platform password management app for Web, Android, and iOS_

![SafePass Logo](safepass_frontend/lib/assets/logo.png)

---

## **📖 Introduction**

SafePass is a secure and user-friendly application that simplifies login and registration while ensuring your data remains safe. Designed to work seamlessly across **Web**, **Android**, and **iOS**, SafePass uses a **Flutter** frontend and a **Flask** backend powered by **MySQL** for persistent storage.

---

## **📌 Overview**

- **Frontend:** Flutter (Web, Android, iOS)
- **Backend:** Flask (Python REST API)
- **Database:** MySQL
- **Security:** JWT Authentication, password hashing
- **Cross-platform:** Runs on web browsers, Android devices, and iOS devices

---

## **✨ Features**

✅ User Registration  
✅ Secure Login with JWT Authentication  
✅ Password encryption before storage  
✅ Cross-platform support (Web, Android, iOS)  
✅ Responsive UI with Material Design  
✅ Simple, clean, and scalable architecture

---

## **🛠 Tech Stack**

**Frontend (Flutter)**

- Flutter SDK (>= 3.8.1)
- Dart
- Device Preview (for responsive UI testing)

**Backend (Flask)**

- Flask 2.3.3
- Flask-MySQLdb 1.0.1
- Flask-JWT-Extended 4.6.0
- Flask-Cors 4.0.0
- Werkzeug 2.3.7

**Database**

- MySQL

---

## **📂 Project Structure**

### **Backend**

```
safepass_backend/
├── app.py                 # Flask application entry-point
├── config.py              # Environment & Flask configuration
├── extensions.py          # MySQL, JWT, CORS initialisation
├── requirements/          # Python dependencies
├── database/
│   └── schema.sql         # SQL schema scripts
├── models/
│   └── user.py            # User model
└── routes/
    └── auth_routes.py     # Authentication endpoints
```

### **Frontend**

```
safepass_frontend/
├── pubspec.yaml           # Flutter dependencies
├── lib/
│   ├── main.dart          # Flutter entry-point
│   ├── config.dart        # API base URL
│   ├── pages/
│   │   ├── splash_page.dart
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   │   └── home_page.dart
│   └── widgets/
│       ├── custom_textfield.dart
│       └── primary_button.dart
```

---

## **📸 Screenshots**

| Web                                    | Android                                        | iOS                                    |
| -------------------------------------- | ---------------------------------------------- | -------------------------------------- |
| ![Web Screenshot](screenshots/web.png) | ![Android Screenshot](screenshots/android.png) | ![iOS Screenshot](screenshots/ios.png) |

---

## **⚙️ Setup & Run Instructions**

### **1. Prerequisites**

**Frontend**

- Flutter SDK (>= 3.8.1)
- Dart (comes with Flutter)
- Android Studio (with Flutter & Dart plugins)
- Xcode (for iOS, macOS only)
- Chrome browser (for web testing)

**Backend**

- Python 3.10 or 3.11
- pip (Python package installer)
- MySQL server running locally

---

### **2. Clone the Repository**

```bash
git clone <your-repo-link>
cd <your-repo-name>


### **Configure MySQL Database**

```

CREATE DATABASE IF NOT EXISTS user_db;
USE user_db;

CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
email VARCHAR(120) UNIQUE NOT NULL,
password VARCHAR(200) NOT NULL
);

```

### **Backend Setup (Flask API)**

```

cd safepass_backend
python -m venv .venv
.venv\Scripts\activate # For Windows

# source .venv/bin/activate # For macOS/Linux

pip install -r requirements.txt
python app.py

```
Backend will run at: http://127.0.0.1:5000

### **Frontend Setup (Flutter App)**
```

cd ../safepass_frontend
flutter pub get

```
### **Connect Frontend & Backend**
In lib/config.dart of the Flutter app, update:
```

const String apiBaseUrl = "http://127.0.0.1:5000";

```
For physical mobile devices, replace 127.0.0.1 with your local IP address.

👨‍💻 Author

Afsar Uddin
💼 Aspiring Software Engineer | 🌏 Bangladesh
📧 Email: afsaruddin12133@gmail.com
```
