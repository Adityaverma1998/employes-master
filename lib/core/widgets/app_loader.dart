import 'package:flutter/material.dart';

class AppLoader {
  static bool _isShowing = false;

  static void show(BuildContext context) {
    if (_isShowing) return;

    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void hide(BuildContext context) {
    if (!_isShowing) return;

    _isShowing = false;

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
