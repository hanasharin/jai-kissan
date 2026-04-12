import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _slide;
  late Animation<double> _taglineFade;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _slide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _taglineFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
    );

    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 2.0-style: background image
          Image.asset('assets/images/emarald.jpg', fit: BoxFit.cover),
          // Emerald overlay
          Container(color: JKTheme.emerald.withOpacity(0.72)),

          // Radial glows (1.0 style)
          Positioned(
            top: -100,
            left: -60,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    JKTheme.emeraldLight.withOpacity(0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [JKTheme.sand.withOpacity(0.15), Colors.transparent],
                ),
              ),
            ),
          ),

          // Center content with 1.0 animations
          Center(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) => Opacity(
                opacity: _fade.value,
                child: Transform.translate(
                  offset: Offset(0, _slide.value),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo — beige box like 2.0 buttons, eco icon like 1.0
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: JKTheme.beige,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.eco_rounded,
                          color: JKTheme.emerald,
                          size: 44,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Jai Kissan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: JKTheme.beige,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: _taglineFade.value,
                        child: Text(
                          'Smart Crop Intelligence',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: JKTheme.beige.withOpacity(0.65),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Version tag
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'v1.0',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: JKTheme.beige.withOpacity(0.25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
