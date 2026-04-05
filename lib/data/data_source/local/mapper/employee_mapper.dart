import 'package:employes_master/data/data_source/local/models/employee_entity.dart';
import 'package:employes_master/domain/entities/employee.dart';

extension EmployeeMapper on EmployeeEntity {
  Employee toDomain() {
    return Employee(
      empCode: empCode,
      empName: empName,
      mobile: mobile,
      dob: dob,
      doj: doj,
      salary: salary,
      address: address,
      remark: remark,
    );
  }
}

extension EmployeeToEntity on Employee {
  EmployeeEntity toEntity() {
    return EmployeeEntity(
      empCode: empCode,
      empName: empName,
      mobile: mobile,
      dob: dob,
      doj: doj,
      salary: salary,
      address: address,
      remark: remark,
    );
  }
}
