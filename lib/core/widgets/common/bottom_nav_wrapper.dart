import 'package:employes_master/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavWrapper extends StatelessWidget {
  final Widget child;

  const BottomNavWrapper({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).fullPath;

    if (location == AppRoutes.home) return 0;
    if (location == AppRoutes.employees) return 1;

    return 0;
  }

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
      body: child,

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
