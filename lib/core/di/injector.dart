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
import 'package:employes_master/domain/usecase/employee/update_employee_usecase.dart';
import 'package:employes_master/presentation/auth/bloc/auth_bloc.dart';
import 'package:employes_master/presentation/employees/bloc/employee_bloc.dart';
import 'package:employes_master/presentation/home/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

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

  ///  EMPLOYEE
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetEmployeesUseCase(sl()));
  sl.registerLazySingleton(() => AddEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => DeleteEmployeeUseCase(sl()));

  ///  BLOCS
  sl.registerFactory(() => HomeBloc(sl()));

  sl.registerFactory(() => EmployeeBloc(sl()));
}
