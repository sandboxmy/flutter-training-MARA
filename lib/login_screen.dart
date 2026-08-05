import 'package:flutter/material.dart';

import 'home_page.dart';
import 'register_screen.dart';
import 'task_service.dart';

const Color primary = Color(0xFF6C72C9);

/// LOGIN SCREEN
/// Email + password form with validation, then API login → Home.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.prefilledEmail, this.prefilledName});

  static const String routeName = '/login';

  // Optional values from Register screen
  final String? prefilledEmail;
  final String? prefilledName;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TaskService _taskService = TaskService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool hidePassword = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _email.text = widget.prefilledEmail ?? '';
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // Submit login form to API
  Future<void> _submit() async {
    // Validate email + password
    if (!_form.currentState!.validate()) return;
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final auth = await _taskService.login(
        email: _email.text.trim(),
        password: _password.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful! Welcome, ${auth.user.name}'),
          backgroundColor: Colors.green,
        ),
      );

      // Token, name, email already saved in SharedPreferences by TaskService
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } on TaskServiceException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    const Icon(Icons.check_circle, size: 64, color: primary),
                    const SizedBox(height: 16),
                    Text(
                      widget.prefilledName != null
                          ? 'Welcome, ${widget.prefilledName}!'
                          : 'Welcome back!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Log in to manage your tasks',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Email
                    TextFormField(
                      controller: _email,
                      enabled: !_loading,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Enter email'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _password,
                      enabled: !_loading,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: _loading
                              ? null
                              : () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Enter password' : null,
                    ),
                    const SizedBox(height: 24),

                    // Log In button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _loading ? null : _submit,
                        child: _loading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Log In'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Create Account button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _loading
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                        child: const Text('Create an Account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
