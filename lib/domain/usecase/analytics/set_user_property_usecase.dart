import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class SetUserPropertyUseCase {
  final AnalyticsRepository repository;

  SetUserPropertyUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String name, String? value) {
    return repository.setUserProperty(name, value);
  }
}
