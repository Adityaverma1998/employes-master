import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class SetUserIdUseCase {
  final AnalyticsRepository repository;

  SetUserIdUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String? id) {
    return repository.setUserId(id);
  }
}
