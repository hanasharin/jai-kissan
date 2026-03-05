import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'dashboard.dart';
import 'sign_up.dart';
import 'todo_page.dart';
import 'profile_page.dart';

void main() {
  runApp(const JaiKissanApp());
}

class JaiKissanApp extends StatelessWidget {
  const JaiKissanApp({super.key});

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF203D2B);
    const beige = Color(0xFFFAF2D5);

    return MaterialApp(
      title: 'Jai Kissan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.light(
          primary: emerald,
          secondary: beige,
          background: beige,
          onPrimary: Colors.white,
          onSecondary: emerald,
          onBackground: emerald,
        ),
        scaffoldBackgroundColor: beige,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: emerald),
          bodyMedium: TextStyle(color: emerald),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: emerald.withOpacity(0.1),
          labelStyle: const TextStyle(color: emerald),
          hintStyle: TextStyle(color: emerald.withOpacity(0.6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: emerald.withOpacity(0.3)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: emerald,
            foregroundColor: beige,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 3,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const Dashboard(),
        '/signup': (context) => const SignUpPage(),
        '/todo': (context) => const ToDoPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
