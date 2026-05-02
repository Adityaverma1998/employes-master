import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class LogEventUseCase {
  final AnalyticsRepository repository;

  LogEventUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String name, {Map<String, Object?>? parameters}) {
    return repository.logEvent(name, parameters: parameters);
  }
}
