import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/data/data_source/local/dao/employee_dao.dart';
import 'package:employes_master/data/data_source/local/mapper/employee_mapper.dart';
import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/repository/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDao dao;

  EmployeeRepositoryImpl(this.dao);

  @override
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      final result = await dao.getEmployees();
      final data = result.map((e) => e.toDomain()).toList();
      return Right(data);
    } catch (e) {
      return Left(DatabaseFailure("Failed to fetch employees"));
    }
  }

  @override
  Future<Either<Failure, Employee?>> getEmployeeById(int id) async {
    try {
      final result = await dao.getEmployeeById(id);
      return Right(result?.toDomain());
    } catch (e) {
      return Left(DatabaseFailure("Failed to fetch employee"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addEmployee(Employee employee) async {
    try {
      await dao.insertEmployee(employee.toEntity());
      return const Right(unit);
    } catch (e) {
      print("check error are $e");
      return Left(DatabaseFailure("Failed to add employee"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEmployee(Employee employee) async {
    try {
      await dao.updateEmployee(employee.toEntity());
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure("Failed to update employee"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEmployee(Employee employee) async {
    try {
      await dao.deleteEmployee(employee.toEntity());
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure("Failed to delete employee"));
    }
  }
}
