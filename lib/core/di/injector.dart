import 'package:employes_master/core/database/app_database.dart';
import 'package:employes_master/data/data_source/local/dao/employee_dao.dart';
import 'package:employes_master/data/data_source/remote/auth_remote_datasource.dart';
import 'package:employes_master/data/data_source/repository_impl/auth_repository_impl/auth_repository_impl.dart';
import 'package:employes_master/data/data_source/repository_impl/employee_repository_impl/employee_repository_impl.dart';
import 'package:employes_master/domain/repository/auth_repository.dart';
import 'package:employes_master/domain/repository/employee_repository.dart';
import 'package:employes_master/domain/usecase/auth/login_usecase.dart';
import 'package:employes_master/domain/usecase/auth/logout_usecase.dart';
import 'package:employes_master/domain/usecase/employee/add_employee_usecase.dart';
import 'package:employes_master/domain/usecase/employee/delete_employee_usecase.dart';
import 'package:employes_master/domain/usecase/employee/get_employee_by_id.dart';
import 'package:employes_master/domain/usecase/employee/update_employee_usecase.dart';
import 'package:employes_master/presentation/auth/bloc/auth_bloc.dart';
import 'package:employes_master/presentation/employees/bloc/add_employees_bloc/add_employee_bloc.dart';
import 'package:employes_master/presentation/employees/bloc/employee_bloc.dart';
import 'package:employes_master/presentation/home/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:employes_master/data/data_source/remote/analytics_remote_datasource.dart';
import 'package:employes_master/data/data_source/repository_impl/analytics_repository_impl/analytics_repository_impl.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';
import 'package:employes_master/domain/usecase/analytics/log_event_usecase.dart';
import 'package:employes_master/domain/usecase/analytics/log_login_usecase.dart';
import 'package:employes_master/domain/usecase/analytics/log_sign_up_usecase.dart';
import 'package:employes_master/domain/usecase/analytics/set_current_screen_usecase.dart';
import 'package:employes_master/domain/usecase/analytics/set_user_id_usecase.dart';
import 'package:employes_master/domain/usecase/analytics/set_user_property_usecase.dart';

import '../../domain/usecase/employee/get_employee_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///  DATABASE
  final database = await $FloorAppDatabase
      .databaseBuilder('employeer_database.db')
      .build();

  sl.registerLazySingleton<AppDatabase>(() => database);
  sl.registerLazySingleton<EmployeeDao>(() => database.employeeDao);

  ///  AUTH
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerFactory(() => AuthBloc(loginUseCase: sl(), logoutUseCase: sl()));

  ///  ANALYTICS
  sl.registerLazySingleton(() => FirebaseAnalytics.instance);
  sl.registerLazySingleton(() => AnalyticsRemoteDataSource(sl()));

  sl.registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LogEventUseCase(sl()));
  sl.registerLazySingleton(() => SetUserIdUseCase(sl()));
  sl.registerLazySingleton(() => SetUserPropertyUseCase(sl()));
  sl.registerLazySingleton(() => SetCurrentScreenUseCase(sl()));
  sl.registerLazySingleton(() => LogLoginUseCase(sl()));
  sl.registerLazySingleton(() => LogSignUpUseCase(sl()));
  ///  EMPLOYEE
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetEmployeesUseCase(sl()));
  sl.registerLazySingleton(() => AddEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => DeleteEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => GetEmployeeByIdUseCase(sl()));

  ///  BLOCS
  sl.registerFactory(() => HomeBloc(sl<GetEmployeesUseCase>()));

  sl.registerFactory(
    () => EmployeeBloc(sl<GetEmployeesUseCase>(), sl<DeleteEmployeeUseCase>()),
  );
  sl.registerFactory(
    () => AddEmployeeBloc(
      addEmployee: sl<AddEmployeeUseCase>(),
      updateEmployee: sl<UpdateEmployeeUseCase>(),
      getEmployeeById: sl<GetEmployeeByIdUseCase>(),
    ),
  );
}
