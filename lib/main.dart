import 'package:employes_master/core/di/injector.dart';
import 'package:employes_master/core/routes/routers.dart';
import 'package:employes_master/presentation/auth/bloc/auth_bloc.dart';
import 'package:employes_master/presentation/employees/bloc/employee_bloc.dart';
import 'package:employes_master/presentation/home/bloc/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = sl<AuthBloc>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => authBloc..add(CheckAuthEvent())),
            BlocProvider(
              create: (_) => sl<HomeBloc>()..add(LoadHomeDataEvent()),
            ),

            /// 👨‍💼 EMPLOYEE
            BlocProvider(create: (_) => sl<EmployeeBloc>()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routerConfig,
          ),
        );
      },
    );
  }
}
