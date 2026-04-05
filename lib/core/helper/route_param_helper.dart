class RouteParamHelper {
  static int? toNullableInt(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return int.tryParse(value);
  }

  static String? toNullableString(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value;
  }

  static bool toBool(String? value) {
    return value == 'true';
  }
}
