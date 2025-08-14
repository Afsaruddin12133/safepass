import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

// Homepage..
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? token;
  String? email;
  String? displayName;

// Spinner While Fetching Data..
  bool loading = true;

  // Load User Data when Screen is Opened..
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
// Extracts Name form Email (Split by @)..
  String _extractNameFromEmail(String email) {
    String namePart = email.split('@')[0];
    return namePart
        .replaceAll(RegExp(r'[._]'), ' ')
        .split(' ')
        .map((word) => word.isNotEmpty
        ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
        : '')
        .join(' ');
  }

// Load Token(JWT) and Email from Local Storage..
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getString('auth_token');
    final e = prefs.getString('email');

    setState(() {
      token = t;
      email = e;
      displayName = (e != null && e.isNotEmpty)
          ? _extractNameFromEmail(e)
          : null;
      loading = false;
    });
  }
// Remove all Stored User Data & Navigates to Login Page..
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  // Widget for Home Page..
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Show Spinner until user data is loaded..
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('Home'),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 40),
              // Circle Profile Icon..
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person,
                    size: 60, color: Colors.teal.shade700),
              ),
              const SizedBox(height: 20),

              // Welcome Massage with User Name..
              Text(
                'Welcome, ${displayName ?? 'User'} 👋',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Display Email Address..
              Text(
              'Email: ${email ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),

              // Container for Account Info(Name,Token)..
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Your Account Info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // Display User Name into Card..
                            children: [
                              const Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                displayName ?? 'No name found',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 15),

                              // Display Token Generated by Backend..
                              const Text(
                                'Token',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                token ?? 'No token found',
                                style:
                                const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
