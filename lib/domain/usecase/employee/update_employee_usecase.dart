import 'package:dartz/dartz.dart';
import 'package:employes_master/core/failure.dart';
import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/repository/employee_repository.dart';

class UpdateEmployeeUseCase {
  final EmployeeRepository repository;

  UpdateEmployeeUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Employee employee) {
    return repository.updateEmployee(employee);
  }
}
