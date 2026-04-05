import 'package:employes_master/core/routes/routes.dart';
import 'package:employes_master/presentation/auth/view/screen/login_page.dart';
import 'package:employes_master/presentation/auth/view/screen/splash_page.dart';
import 'package:employes_master/presentation/employees/view/screen/employee_list_screen.dart';
import 'package:employes_master/presentation/home/view/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///  Navigator Key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///  Custom Transition
Page<dynamic> buildPageWithTransition({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOut);

      final slide = Tween<Offset>(
        begin: const Offset(0.05, 0),
        end: Offset.zero,
      ).animate(fade);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}

///  GoRouter
GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,

  initialLocation: AppRoutes.splash,
  redirect: (context, state) {
    debugPrint("state: ${state.fullPath}");
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          buildPageWithTransition(child: const LoginPage(), state: state),
    ),
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) =>
          buildPageWithTransition(child: const SplashScreen(), state: state),
    ),

    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          buildPageWithTransition(child: const HomeScreen(), state: state),
    ),

    GoRoute(
      path: AppRoutes.employees,
      pageBuilder: (context, state) => buildPageWithTransition(
        child: const EmployeeListScreen(),
        state: state,
      ),
    ),
  ],
);
