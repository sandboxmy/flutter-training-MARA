import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_screen.dart';

/// REGISTER SCREEN
/// Form with optional username, required email + password.
/// After submit → go to Home and pass name (if any) + email.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _hidePass = true;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Validate email + password (username is optional)
    if (!_form.currentState!.validate()) return;

    final name = _username.text.trim();

    Navigator.pushReplacementNamed(
      context,
      HomePage.routeName,
      arguments: {
        'username': name.isEmpty ? 'User' : name,
        'email': _email.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              // Username (optional — no validator)
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter email' : null,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _password,
                obscureText: _hidePass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                    icon: Icon(
                      _hidePass ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter password' : null,
              ),
              const SizedBox(height: 24),

              // Create Account button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _submit,
                  child: const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 8),

              // Back to Login
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
