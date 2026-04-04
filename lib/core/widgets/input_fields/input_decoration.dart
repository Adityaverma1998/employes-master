import 'package:employes_master/core/routes/routers.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  CustomInputDecoration._internal();

  static InputDecoration outlineInputDecoration({
    String? labelText,
    Widget? suffixIcon,
    String? hintText,
    Widget? prefixIcon,
    String? helperText,
    String? prefixText,
    bool enable = true,
    Color? fillColor,
    InputBorder? focusBorder,
  }) {
    final ThemeData theme = Theme.of(navigatorKey.currentContext!);
    return InputDecoration(
      enabled: enable,
      errorMaxLines: 2,
      prefixText: prefixText,
      helperMaxLines: 3,
      counterText: '',
      hintText: hintText,
      filled: fillColor != null,
      fillColor: Colors.white,
      hintStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      labelText: labelText,
      helperText: helperText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      labelStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      helperStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(100),
      ),
      focusedBorder:
          focusBorder ??
          OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(100),
          ),
    );
  }

  static InputDecoration filledDecoration({
    required BuildContext context,
    String? labelText,
    Widget? suffixIcon,
    String? hintText,
    Widget? prefixIcon,
    String? helperText,
  }) {
    // final ThemeData theme = Theme.of(navigatorKey.currentContext!);
    final theme = Theme.of(context);
    return InputDecoration(
      filled: true,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(4),
      ),
      hintStyle: TextStyle(
        fontSize: 16,
        color: Color(0xFF000000),
        fontWeight: FontWeight.w600,
      ),

      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  static InputDecoration squareDecoration({
    required BuildContext context,
    String? labelText,
    Widget? suffixIcon,
    String? hintText,
    Widget? prefixIcon,
    String? helperText,
  }) {
    // final ThemeData theme = Theme.of(navigatorKey.currentContext!);
    final theme = Theme.of(context);

    // final ThemeData theme = Theme.of(navigatorKey.currentContext!);

    return InputDecoration(
      filled: false,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          width: 1,
          color: theme.colorScheme.outline,
        ), // 🔹 outline color
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.outline, width: 1),
      ),

      hintStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF000000),
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static InputDecoration emptyDecoration({
    String? labelText,
    Widget? suffixIcon,
    String? hintText,
    Widget? prefixIcon,
    String? helperText,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      isDense: true,

      filled: true,
      fillColor: Colors.transparent,
      // or Colors.white or transparent
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF000000),
        fontWeight: FontWeight.w300,
      ),
      counter: Offstage(),
      helperText: helperText,
      suffixIcon: suffixIcon,
      suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
      prefixIcon: prefixIcon,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
  }
}
