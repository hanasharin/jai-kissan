import 'package:flutter/material.dart';
import 'theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/dash.jpg', fit: BoxFit.cover),
          Container(color: JaikissanTheme.emerald.withValues(alpha: 0.5)),
          SafeArea(
            child: Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: JaikissanTheme.beige,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Profile',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: JaikissanTheme.beige),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: JaikissanTheme.beige,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'R',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: JaikissanTheme.emerald,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Ravi Kumar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: JaikissanTheme.beige,
                  ),
                ),
                Text(
                  'Farmer · Tirur, Kerala',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: JaikissanTheme.beige.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 32),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _ProfileTile(
                          label: 'Phone Number',
                          value: '+91 9876543210',
                          icon: Icons.phone_outlined,
                        ),
                        _ProfileTile(
                          label: 'Land Size',
                          value: '5 Acres',
                          icon: Icons.landscape_outlined,
                        ),
                        _ProfileTile(
                          label: 'Crop Preference',
                          value: 'Paddy',
                          icon: Icons.eco_outlined,
                        ),
                        _ProfileTile(
                          label: 'District',
                          value: 'Malappuram',
                          icon: Icons.location_city_outlined,
                        ),
                        _ProfileTile(
                          label: 'Village',
                          value: 'Tirur',
                          icon: Icons.home_outlined,
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/login',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: JaikissanTheme.beige,
                              foregroundColor: JaikissanTheme.emerald,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            child: const Text('Sign Out'),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _ProfileTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: JaikissanTheme.beige.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: JaikissanTheme.beige.withOpacity(0.7), size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: JaikissanTheme.beige.withOpacity(0.65),
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: JaikissanTheme.beige,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
