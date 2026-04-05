import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/repository/employee_repository.dart';

class GetEmployeeByIdUseCase {
  final EmployeeRepository repository;

  GetEmployeeByIdUseCase(this.repository);

  Future<Either<Failure, Employee?>> call(int id) {
    return repository.getEmployeeById(id);
  }
}
