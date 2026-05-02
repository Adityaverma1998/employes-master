import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, Unit>> logEvent(String name, {Map<String, Object?>? parameters});
  Future<Either<Failure, Unit>> setUserId(String? id);
  Future<Either<Failure, Unit>> setUserProperty(String name, String? value);
  Future<Either<Failure, Unit>> setCurrentScreen(String screenName, {String? screenClassOverride});
  Future<Either<Failure, Unit>> logLogin(String? loginMethod);
  Future<Either<Failure, Unit>> logSignUp(String signUpMethod);
}
