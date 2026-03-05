import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF203D2B);
    const beige = Color(0xFFFAF2D5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: emerald,
        title: Text(
          'Profile',
          style: const TextStyle(fontFamily: 'Poppins', color: beige),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFAF2D5)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: emerald.withOpacity(0.6),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetail('Farmer Name', 'Ravi Kumar', emerald, beige),
              _buildDetail('Phone Number', '+91 9876543210', emerald, beige),
              _buildDetail('Land Size', '5 Acres', emerald, beige),
              _buildDetail('Crop Preference', 'Paddy', emerald, beige),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value, Color emerald, Color beige) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: emerald,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: beige,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: beige,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
