import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

// Main Entry Point of the App..
void main() {
  runApp(
      DevicePreview(
          builder: (context) =>  MyApp()
      )
  );
}

// Main App widget..
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safepass',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
      ),

      // Routes for Easy Navigation..
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home':(context) => const HomePage()
      },
    );
  }
}
