import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Signup/birth_screen.dart';
import 'reset_password_email.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      if (userCredential.user != null) {
        if (mounted) {
          // Navigate to home screen after successful login
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              /// 🔰 LOGO + APP NAME
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/logo.png', height: 160),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// 👋 Welcome Text
              RichText(
                text: const TextSpan(
                  text: "Welcome Back, ",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Athlete",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),
              const Text(
                "Sign in to track your progress",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              _inputField("Email", controller: _emailController),
              const SizedBox(height: 16),
              _inputField(
                "Password",
                isPassword: true,
                controller: _passwordController,
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color.fromRGBO(255, 0, 0, 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResetPasswordEmail(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forget Password ?",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              _isLoading
                  ? const CircularProgressIndicator(color: Colors.green)
                  : _greenButton("Log In", _signIn),

              const SizedBox(height: 20),

              /// 🔵 Google Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text("Sign in with Google"),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// 🔗 Sign Up
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don’t have an account ? ",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BirthScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String hint, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      enabled: !_isLoading,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: isPassword ? const Icon(Icons.visibility_outlined) : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _greenButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
