import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/entities/user.dart';
import 'package:employes_master/domain/repository/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}
