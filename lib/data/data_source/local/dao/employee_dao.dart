import 'package:floor/floor.dart';
import 'models/employee_entity.dart';

@dao
abstract class EmployeeDao {
  // Exclude soft-deleted
  @Query('SELECT * FROM employees WHERE isDeleted = 0')
  Future<List<EmployeeEntity>> getEmployees();

  @Query('SELECT * FROM employees WHERE empCode = :id')
  Future<EmployeeEntity?> getEmployeeById(int id);

  // For sync — get all unsynced records
  @Query('SELECT * FROM employees WHERE isSynced = 0')
  Future<List<EmployeeEntity>> getUnsyncedEmployees();

  // For pull sync — find by firebase ID
  @Query('SELECT * FROM employees WHERE firebaseId = :firebaseId')
  Future<EmployeeEntity?> getEmployeeByFirebaseId(String firebaseId);

  @insert
  Future<void> insertEmployee(EmployeeEntity employee);

  @update
  Future<void> updateEmployee(EmployeeEntity employee);

  @delete
  Future<void> deleteEmployee(EmployeeEntity employee);

  // Mark synced after Firebase push
  @Query('UPDATE employees SET isSynced = 1, firebaseId = :firebaseId WHERE empCode = :localId')
  Future<void> markSynced(int localId, String firebaseId);
}