import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/data/data_source/remote/auth_remote_datasource.dart';
import 'package:employes_master/domain/entities/user.dart';
import 'package:employes_master/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remote.login(email, password);

      return Right(User(uid: result.user!.uid, email: result.user!.email!));
    } catch (e) {
      return Left(Failure("Invalid email or password"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remote.logout();
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Logout failed"));
    }
  }
}
