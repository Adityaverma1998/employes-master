class DateTimeUtils {
  DateTimeUtils._();

  // ─────────────────────────────────────────────
  // 🔹 FORMATTERS
  // ─────────────────────────────────────────────

  /// UI Format → dd/MM/yyyy
  static String formatUI(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  /// ISO Format → yyyy-MM-ddTHH:mm:ss
  static String formatISO(DateTime date) {
    return date.toIso8601String();
  }

  // ─────────────────────────────────────────────
  // 🔹 PARSERS
  // ─────────────────────────────────────────────

  /// Parse ISO → DateTime
  static DateTime? parseISO(String? date) {
    if (date == null || date.isEmpty) return null;
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  /// Parse UI → DateTime (dd/MM/yyyy)
  static DateTime? parseUI(String? date) {
    if (date == null || date.isEmpty) return null;
    try {
      final parts = date.split('/');
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (_) {
      return null;
    }
  }

  /// Smart parser (auto-detect format)
  static DateTime? parse(String? date) {
    if (date == null || date.isEmpty) return null;

    // ISO format
    if (date.contains('-')) {
      return parseISO(date);
    }

    // UI format
    if (date.contains('/')) {
      return parseUI(date);
    }

    return null;
  }

  // ─────────────────────────────────────────────
  // 🔹 HELPERS
  // ─────────────────────────────────────────────

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.month == b.month && a.year == b.year;
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }
}
