import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployees();

  Future<Either<Failure, Employee?>> getEmployeeById(int id);

  Future<Either<Failure, Unit>> addEmployee(Employee employee);

  Future<Either<Failure, Unit>> updateEmployee(Employee employee);

  Future<Either<Failure, Unit>> deleteEmployee(Employee employee);
}
