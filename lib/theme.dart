import 'package:flutter/material.dart';

class JKTheme {
  // ── Palette (Jaikissan 2.0 colors) ───────────────────
  static const emerald = Color(0xFF203D2B);
  static const emeraldMid = Color(0xFF2E5C3E);
  static const emeraldLight = Color(0xFF4A8C63);
  static const beige = Color(0xFFFAF2D5);
  static const beigeLight = Color(0xFFFDF8EC);
  static const beigeDark = Color(0xFFEDE3B8);
  static const sand = Color(0xFFD4A853);
  static const sandLight = Color(0xFFF5E6C8);

  // Neutral / ink
  static const ink = Color(0xFF0F1F16);
  static const inkLight = Color(0xFF3A5A45);
  static const offWhite = Color(0xFFF5F0E0);
  static const white = Color(0xFFFFFFFF);
  static const error = Color(0xFFCF4A3C);

  // ── Typography (Poppins from 2.0) ────────────────────
  static const _base = TextStyle(fontFamily: 'Poppins', color: ink);

  static final TextTheme textTheme = TextTheme(
    displayLarge: _base.copyWith(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.1,
    ),
    displayMedium: _base.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.0,
      height: 1.2,
    ),
    headlineLarge: _base.copyWith(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
    headlineMedium: _base.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    ),
    headlineSmall: _base.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    titleLarge: _base.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    titleMedium: _base.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: _base.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
    ),
    bodyMedium: _base.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodySmall: _base.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: inkLight,
    ),
    labelLarge: _base.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: _base.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: inkLight,
    ),
  );

  // ── ThemeData ─────────────────────────────────────────
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: offWhite,
    colorScheme: const ColorScheme.light(
      primary: emerald,
      secondary: sand,
      surface: beige,
      error: error,
      onPrimary: white,
      onSecondary: ink,
      onSurface: ink,
    ),
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: emerald,
      foregroundColor: beige,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: beige,
        letterSpacing: -0.3,
      ),
      iconTheme: IconThemeData(color: beige),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: emerald,
        foregroundColor: beige,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: beige,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFCDC9A5), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFCDC9A5), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: emerald, width: 2),
      ),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: inkLight,
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        color: inkLight.withOpacity(0.6),
        fontSize: 14,
      ),
    ),
  );
}

// ── Shared Widgets ────────────────────────────────────

/// Primary full-width button
class JKButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool loading;
  final bool outlined;
  final IconData? icon;

  const JKButton({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.outlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: outlined
          ? OutlinedButton.icon(
              onPressed: loading ? null : onTap,
              icon: icon != null
                  ? Icon(icon, size: 18)
                  : const SizedBox.shrink(),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: JKTheme.emerald,
                side: const BorderSide(color: JKTheme.emerald, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: loading ? null : onTap,
              child: loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: JKTheme.beige,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, size: 18),
                          const SizedBox(width: 8),
                        ],
                        Text(label),
                      ],
                    ),
            ),
    );
  }
}

/// Card with beige fill + subtle border — 2.0 feel inside 1.0 layout
class JKCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final VoidCallback? onTap;

  const JKCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color ?? JKTheme.beige,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFCDC9A5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: JKTheme.emerald.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Glassmorphism card (used on image-background pages like 2.0)
class JKGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const JKGlassCard({super.key, required this.child, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: JKTheme.emerald.withOpacity(0.72),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: JKTheme.beige.withOpacity(0.2), width: 1),
        ),
        child: child,
      ),
    );
  }
}

/// Text field with emerald/beige styling
class JKTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const JKTextField({
    super.key,
    required this.label,
    this.hint,
    this.obscure = false,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        color: JKTheme.ink,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: JKTheme.inkLight, size: 20)
            : null,
        suffixIcon: suffix,
      ),
    );
  }
}
