import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import '../../utils/widgets.dart';

class AuthMethodScreen extends StatelessWidget {
  const AuthMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ResponsivePage(
        child: Column(
          children: [
            Gap(30),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  iconSize: 28,
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
              ],
            ),
            Gap(20),
            const Text(
              "Choose Signup Method",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Select how you'd like to create your account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            // Email/Password Option
            _buildAuthOption(
              context,
              icon: Icons.email,
              title: "Email & Password",
              subtitle: "Create account with email and password",
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageTransitions.slideAndFadeTransition(
                    const EmailPasswordScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Phone Option
            _buildAuthOption(
              context,
              icon: Icons.phone,
              title: "Phone Number",
              subtitle: "Verify with SMS code",
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageTransitions.slideAndFadeTransition(
                    const PhoneVerificationScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Google Option
            _buildAuthOption(
              context,
              icon: Icons.g_mobiledata,
              title: "Google",
              subtitle: "Continue with Google account",
              onTap: () {
                // TODO: Implement Google sign in
                _showComingSoonDialog(context);
              },
            ),
            const Spacer(),
            // Skip for now button
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/success');
              },
              child: const Text(
                "Skip for now",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(19, 236, 91, 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.green, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Coming Soon"),
        content: const Text("Google sign-in will be available soon."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

class EmailPasswordScreen extends StatefulWidget {
  const EmailPasswordScreen({super.key});

  @override
  State<EmailPasswordScreen> createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Create user with email and password
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account created successfully! Please check your email for verification.',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to success screen
        Navigator.pushReplacementNamed(context, '/success');
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
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters long.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ResponsivePage(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gap(30),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.black,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                ],
              ),
              Gap(20),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Enter your email and password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: _validatePassword,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: _validateConfirmPassword,
                enabled: !_isLoading,
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
              const Spacer(),
              // Sign in link
              Center(
                child: TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.green)
                  : NextButton(
                      height: 56,
                      label: 'Create Account',
                      onPressed: _createAccount,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ResponsivePage(
        child: Column(
          children: [
            Gap(30),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  iconSize: 28,
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
              ],
            ),
            Gap(20),
            const Text(
              "Phone Verification",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _codeSent
                  ? "Enter the verification code sent to your phone"
                  : "Enter your phone number to receive a verification code",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            if (!_codeSent) ...[
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
            ] else ...[
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: "Verification Code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.code),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _codeSent = false;
                  });
                },
                child: const Text("Change phone number"),
              ),
            ],
            const Spacer(),
            NextButton(
              height: 56,
              label: _codeSent ? 'Verify & Create Account' : 'Send Code',
              onPressed: () {
                if (!_codeSent) {
                  // TODO: Send verification code
                  setState(() {
                    _codeSent = true;
                  });
                } else {
                  // TODO: Verify code and create account
                  Navigator.pushReplacementNamed(context, '/success');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
