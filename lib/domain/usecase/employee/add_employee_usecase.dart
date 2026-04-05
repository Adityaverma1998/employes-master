import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/repository/employee_repository.dart';

class AddEmployeeUseCase {
  final EmployeeRepository repository;

  AddEmployeeUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Employee employee) {
    return repository.addEmployee(employee);
  }
}
