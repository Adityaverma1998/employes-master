import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class LogLoginUseCase {
  final AnalyticsRepository repository;

  LogLoginUseCase(this.repository);

  Future<Either<Failure, Unit>> call({String? loginMethod}) {
    return repository.logLogin(loginMethod);
  }
}
