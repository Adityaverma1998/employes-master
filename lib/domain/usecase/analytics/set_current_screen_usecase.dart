import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class SetCurrentScreenUseCase {
  final AnalyticsRepository repository;

  SetCurrentScreenUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String screenName, {String? screenClassOverride}) {
    return repository.setCurrentScreen(screenName, screenClassOverride: screenClassOverride);
  }
}
