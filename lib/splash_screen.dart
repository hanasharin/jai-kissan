import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Timer(const Duration(seconds: 2), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emerald = Theme.of(context).colorScheme.primary;
    final beige = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: emerald),
          Positioned(
            top: -40,
            left: -20,
            child: _circle(beige.withOpacity(0.1), 180),
          ),
          Positioned(
            bottom: -50,
            right: -40,
            child: _circle(beige.withOpacity(0.08), 220),
          ),
          FadeTransition(
            opacity: _fade,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Jai Kisaan',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 32,
                      color: beige,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
