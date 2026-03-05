import 'dart:ui';
import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import Dashboard for navigation
import 'sign_up.dart'; // Import SignUpPage for navigation

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emerald = Theme.of(context).colorScheme.primary;
    final beige = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (fixed spelling)
          Image.asset('assets/images/emarald.jpg', fit: BoxFit.cover),
          // Emerald overlay for readability
          Container(color: emerald.withOpacity(0.6)),

          // Foreground login container
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: emerald.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: beige.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: beige,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildTextField(
                      label: 'Username',
                      hint: 'Enter your username',
                      icon: Icons.person,
                      textColor: beige,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      icon: Icons.lock,
                      obscureText: true,
                      textColor: beige,
                    ),
                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement Forgot Password navigation
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontFamily: 'Poppins', color: beige),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: () {
                        // Navigate to Dashboard after login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: beige,
                        foregroundColor: emerald,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontFamily: 'Poppins', color: beige),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to SignUpPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: beige,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(color: beige.withOpacity(0.3)),
                    const SizedBox(height: 8),
                    Text(
                      'Terms and Services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: beige,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required Color textColor,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          style: TextStyle(fontFamily: 'Poppins', color: textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: textColor.withOpacity(0.6),
            ),
            prefixIcon: Icon(icon, color: textColor),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: textColor.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: textColor.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: textColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
