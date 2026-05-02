import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/data/data_source/remote/analytics_remote_datasource.dart';
import 'package:employes_master/domain/repository/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsRemoteDataSource remote;

  AnalyticsRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Unit>> logEvent(String name, {Map<String, Object?>? parameters}) async {
    try {
      await remote.logEvent(name, parameters: parameters);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Failed to log event"));
    }
  }

  @override
  Future<Either<Failure, Unit>> setUserId(String? id) async {
    try {
      await remote.setUserId(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Failed to set user ID"));
    }
  }

  @override
  Future<Either<Failure, Unit>> setUserProperty(String name, String? value) async {
    try {
      await remote.setUserProperty(name, value);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Failed to set user property"));
    }
  }

  @override
  Future<Either<Failure, Unit>> setCurrentScreen(String screenName, {String? screenClassOverride}) async {
    try {
      await remote.setCurrentScreen(screenName, screenClassOverride: screenClassOverride);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Failed to set current screen"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logLogin(String? loginMethod) async {
    try {
      await remote.logLogin(loginMethod);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Failed to log login"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logSignUp(String signUpMethod) async {
    try {
      await remote.logSignUp(signUpMethod);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Failed to log sign up"));
    }
  }
}
