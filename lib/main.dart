import 'package:flutter/material.dart';
import 'theme.dart';
import 'spalsh_screen.dart';
import 'login_page.dart';
import 'sign_up.dart';
import 'dashboard.dart';
import 'yield_predictionpage.dart';
import 'crop_recommed_page.dart';
import 'market_price_page.dart';
import 'profile_page.dart';
import 'todo_page.dart';

void main() {
  runApp(const JaiKissanApp());
}

class JaiKissanApp extends StatelessWidget {
  const JaiKissanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jai Kissan',
      debugShowCheckedModeBanner: false,
      theme: JKTheme.theme,
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
        '/dashboard': (_) => const AppShell(),
        '/yield': (_) => const YieldPredictionPage(),
        '/recommend': (_) => const CropRecommendPage(),
        '/market': (_) => const MarketPricePage(),
        '/profile': (_) => const ProfilePage(),
        '/todo': (_) => const ToDoPage(),
      },
    );
  }
}

// ── App shell — 1.0 IndexedStack + floating nav, 2.0 emerald/beige nav bar ──

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  final _pages = const [
    Dashboard(),
    YieldPredictionPage(),
    CropRecommendPage(),
    MarketPricePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      extendBody: true,
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _FloatingNavBar({required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.show_chart_outlined,
      activeIcon: Icons.show_chart_rounded,
      label: 'Yield',
    ),
    _NavItem(
      icon: Icons.recommend_outlined,
      activeIcon: Icons.recommend_rounded,
      label: 'Crops',
    ),
    _NavItem(
      icon: Icons.storefront_outlined,
      activeIcon: Icons.storefront_rounded,
      label: 'Market',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          // 2.0: emerald nav bar (darker, richer)
          color: JKTheme.emerald,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: JKTheme.emerald.withOpacity(0.35),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.asMap().entries.map((e) {
            final i = e.key;
            final item = e.value;
            final selected = i == currentIndex;
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // 2.0: beige highlight for selected
                  color: selected
                      ? JKTheme.beige.withOpacity(0.18)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: selected
                      ? Border.all(
                          color: JKTheme.beige.withOpacity(0.3),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selected ? item.activeIcon : item.icon,
                      color: selected
                          ? JKTheme.beige
                          : JKTheme.beige.withOpacity(0.4),
                      size: 22,
                    ),
                    if (selected) ...[
                      const SizedBox(width: 7),
                      Text(
                        item.label,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: JKTheme.beige,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon, activeIcon;
  final String label;
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
