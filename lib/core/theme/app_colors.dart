import 'dart:ui';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primarySurface = Color(0xFFEFF6FF); // light blue tint bg

  // App bar / Header
  static const Color appBar = Color(0xFF2563EB);

  // Background
  static const Color pageBg = Color(0xFFF8FAFF);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color inputBg = Color(0xFFF8FAFF);
  static const Color inputFocusBg = Color(0xFFEFF6FF);

  // Border
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color inputBorder = Color(0xFFE2E8F0);
  static const Color inputFocus = Color(0xFF2563EB);
  static const Color divider = Color(0xFFF1F5F9);

  // Text
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status — Active / Success
  static const Color successBg = Color(0xFFDCFCE7);
  static const Color successText = Color(0xFF15803D);
  static const Color successBorder = Color(0xFFBBF7D0);

  // Status — On Leave / Warning
  static const Color warningBg = Color(0xFFFEF9C3);
  static const Color warningText = Color(0xFFA16207);
  static const Color warningBorder = Color(0xFFFDE68A);

  // Status — Inactive / Danger / Delete
  static const Color dangerBg = Color(0xFFFEE2E2);
  static const Color dangerText = Color(0xFFB91C1C);
  static const Color dangerDark = Color(0xFFDC2626);
  static const Color dangerBorder = Color(0xFFFECACA);

  // Status — Info / Badge
  static const Color infoBg = Color(0xFFDBEAFE);
  static const Color infoText = Color(0xFF1D4ED8);

  // Avatar palette (cycles by index)
  static const List<Color> avatarBgs = [
    Color(0xFFDBEAFE), // blue
    Color(0xFFDCFCE7), // green
    Color(0xFFFEF9C3), // yellow
    Color(0xFFEDE9FE), // purple
    Color(0xFFFCE7F3), // pink
    Color(0xFFFEF3C7), // amber
  ];
  static const List<Color> avatarFgs = [
    Color(0xFF1D4ED8),
    Color(0xFF15803D),
    Color(0xFFA16207),
    Color(0xFF6D28D9),
    Color(0xFF9D174D),
    Color(0xFFB45309),
  ];

  /// Returns avatar bg+fg colors based on a string (name/code)
  static Color avatarBg(String seed) =>
      avatarBgs[seed.codeUnits.fold(0, (a, b) => a + b) % avatarBgs.length];
  static Color avatarFg(String seed) =>
      avatarFgs[seed.codeUnits.fold(0, (a, b) => a + b) % avatarFgs.length];

  // Stat card accent colors
  static const Color statBlue = Color(0xFF2563EB);
  static const Color statGreen = Color(0xFF16A34A);
  static const Color statAmber = Color(0xFFD97706);
  static const Color statPurple = Color(0xFF7C3AED);

  // FAB
  static const Color fab = Color(0xFF2563EB);
  static const Color fabIcon = Color(0xFFFFFFFF);

  // Bottom nav
  static const Color navActive = Color(0xFF2563EB);
  static const Color navDot = Color(0xFF2563EB);
  static const Color navInactive = Color(0xFF94A3B8);
}
