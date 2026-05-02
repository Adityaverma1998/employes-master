import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class LogSignUpUseCase {
  final AnalyticsRepository repository;

  LogSignUpUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String signUpMethod) {
    return repository.logSignUp(signUpMethod);
  }
}
