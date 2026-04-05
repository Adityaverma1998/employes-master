import 'package:floor/floor.dart';

@Entity(tableName: 'employees')
class EmployeeEntity {
  @PrimaryKey()
  final int empCode;

  final String empName;
  final String mobile;
  final String dob;
  final String doj;
  final double salary;

  final String? address;
  final String? remark;

  EmployeeEntity({
    required this.empCode,
    required this.empName,
    required this.mobile,
    required this.dob,
    required this.doj,
    required this.salary,
    this.address,
    this.remark,
  });
}
