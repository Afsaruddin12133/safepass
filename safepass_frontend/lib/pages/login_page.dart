import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool loading = false;

  // Validate email and password..
  String? _validate() {
    final email = emailCtrl.text.trim();
    final pw = passCtrl.text;
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (email.isEmpty) return 'Email required';
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email';
    if (pw.isEmpty) return 'Password required';
    if (pw.length < 6) return 'Password must be at least 6 chars';
    return null;
  }

  // handle login API call..
  Future<void> _login() async {
    final err = _validate();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }

    // Show loading state..
    setState(() => loading = true);

    // Send POST request to login API..
    try {
      final res = await http
          .post(
            Uri.parse('${AppConfig.baseUrl}/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'email': emailCtrl.text.trim(),
              'password': passCtrl.text,
            }),
          )
          .timeout(const Duration(seconds: 10));

      // Parse API response..
      final body = json.decode(res.body);

      // Access token is received if Login Successful..
      if (res.statusCode == 200 &&
          body['access_token'] != null &&
          body['email'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', body['access_token']);
        await prefs.setString('email', body['email']);

        // If Login are Successful then Navigate to home page..
        if (mounted) Navigator.pushReplacementNamed(context, '/home');
      } else {
        final msg = body['error'] ?? body['message'] ?? 'Login failed';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
      // Show error if request fails..
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  // Widget for Login Page..
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Scrolling for smaller screens..
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                // Safepass Logo..
                Image.asset('lib/assets/logo.png', height: 260),
                const SizedBox(height: 0),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                // Input Field..
                const SizedBox(height: 18),
                CustomTextField(controller: emailCtrl, label: 'Email'),
                CustomTextField(
                  controller: passCtrl,
                  label: 'Password',
                  obscure: true,
                ),
                // Login Button..
                const SizedBox(height: 12),
                PrimaryButton(label: 'Login', onPressed: _login, busy: loading),
                const SizedBox(height: 8),
                // Navigate to Register Page..
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
