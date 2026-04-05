import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/repository/employee_repository.dart';

class GetEmployeesUseCase {
  final EmployeeRepository repository;

  GetEmployeesUseCase(this.repository);

  Future<Either<Failure, List<Employee>>> call() {
    return repository.getEmployees();
  }
}
