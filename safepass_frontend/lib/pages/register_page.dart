import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:convert';

// Main Registration Screen Widget..
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  // // handle Register API call....
  Future<void> _register() async {
    final err = _validate();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }

    setState(() => loading = true);

    // Send POST request to Registration API..
    try {
      final res = await http
          .post(
            Uri.parse('${AppConfig.baseUrl}/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'email': emailCtrl.text.trim(),
              'password': passCtrl.text,
            }),
          )
          .timeout(const Duration(seconds: 50));

      // Parse API response..
      final body = json.decode(res.body);

      // Registration Error Handling..
      if (res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        if (mounted) Navigator.pushReplacementNamed(context, '/login');
      } else {
        final msg = body['error'] ?? body['message'] ?? 'Registration failed';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  // Widget for Registration Page..
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
              // Safepass Logo..
              children: [
                Image.asset('lib/assets/logo.png', height: 260),
                const SizedBox(height: 0),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                // Input Field..
                const SizedBox(height: 12),
                CustomTextField(controller: emailCtrl, label: 'Email'),
                CustomTextField(
                  controller: passCtrl,
                  label: 'Password',
                  obscure: true,
                ),

                // Registration Button..
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Register',
                  onPressed: _register,
                  busy: loading,
                ),
                const SizedBox(height: 8),
                // Navigate to Login Page..
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
