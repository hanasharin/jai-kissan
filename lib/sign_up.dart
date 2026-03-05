import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage for navigation

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emerald = Theme.of(context).colorScheme.primary;
    final beige = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/emarald.jpg', fit: BoxFit.cover),
          // Emerald overlay
          Container(color: emerald.withOpacity(0.6)),

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
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: beige,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildTextField(
                      'Farmer Name',
                      'Enter your full name',
                      Icons.person,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Age',
                      'Enter your age',
                      Icons.calendar_today,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Gender',
                      'Enter your gender',
                      Icons.people,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Phone Number',
                      'Enter your phone number',
                      Icons.phone,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'State',
                      'Enter your state',
                      Icons.map,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'District',
                      'Enter your district',
                      Icons.location_city,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Village',
                      'Enter your village',
                      Icons.home,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Land Size (in acres)',
                      'Enter land size',
                      Icons.landscape,
                      beige,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Crop Preference',
                      'Enter preferred crop',
                      Icons.eco,
                      beige,
                    ),
                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to LoginPage after registration
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
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
                        'Register',
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
                          "Already have an account?",
                          style: TextStyle(fontFamily: 'Poppins', color: beige),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to LoginPage
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    IconData icon,
    Color textColor,
  ) {
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
