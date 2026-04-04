import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page<dynamic> buildPageWithTransition({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      /// Fade
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOut);

      /// Slide (slight)
      final slide = Tween<Offset>(
        begin: const Offset(0.05, 0),

        /// subtle right → left
        end: Offset.zero,
      ).animate(fade);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// final GoRouter appRouter = GoRouter(
//   initialLocation: AppRoutes.home,
//
//   routes: [
//     ShellRoute(
//       builder: (context, state, child) {
//         return BottomNavWrapper(child: child);
//       },
//
//       routes: [
//         GoRoute(
//           path: AppRoutes.home,
//           name: 'home',
//           pageBuilder: (context, state) =>
//               buildPageWithTransition(child: const HomeScreen(), state: state),
//         ),
//         GoRoute(
//           path: AppRoutes.employees,
//           name: 'employees',
//           pageBuilder: (context, state) => buildPageWithTransition(
//             child: const EmployeesScreen(),
//             state: state,
//           ),
//         ),
//         GoRoute(
//           path: AppRoutes.search,
//           name: 'search',
//           pageBuilder: (context, state) => buildPageWithTransition(
//             child: const SearchScreen(),
//             state: state,
//           ),
//         ),
//         GoRoute(
//           path: AppRoutes.profile,
//           name: 'profile',
//           pageBuilder: (context, state) => buildPageWithTransition(
//             child: const ProfileScreen(),
//             state: state,
//           ),
//         ),
//       ],
//     ),
//   ],
// );
