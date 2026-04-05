import 'package:employes_master/core/routes/routes.dart';
import 'package:employes_master/core/widgets/common/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrimaryLayout extends StatelessWidget {
  final Widget child;

  final String? title;
  final bool showBackButton;
  final VoidCallback? onLogout;
  final PreferredSizeWidget? appBarBottom;

  const PrimaryLayout({
    super.key,
    required this.child,
    this.title,
    this.showBackButton = false,
    this.onLogout,
    this.appBarBottom,
  });

  ///  Get current tab index
  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).fullPath;

    if (location == AppRoutes.home) return 0;
    if (location == AppRoutes.employees) return 1;

    return 0;
  }

  ///  Navigation
  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.employees);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getIndex(context);

    return Scaffold(
      ///  AppBar
      appBar: CommonAppBar(
        title: title,
        showBackButton: showBackButton,
        onLogout: onLogout,
        bottom: appBarBottom,
      ),

      ///  Body
      body: SafeArea(child: child),

      ///  Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Employees'),
        ],
      ),
    );
  }
}
