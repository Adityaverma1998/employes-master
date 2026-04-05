import 'package:employes_master/data/data_source/local/models/employee_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class EmployeeDao {
  @Query('SELECT * FROM employees')
  Future<List<EmployeeEntity>> getEmployees();

  @Query('SELECT * FROM employees WHERE empCode = :id')
  Future<EmployeeEntity?> getEmployeeById(int id);

  @insert
  Future<void> insertEmployee(EmployeeEntity employee);

  @update
  Future<void> updateEmployee(EmployeeEntity employee);

  @delete
  Future<void> deleteEmployee(EmployeeEntity employee);
}
