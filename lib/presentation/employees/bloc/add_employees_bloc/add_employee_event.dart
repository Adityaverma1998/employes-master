part of 'add_employee_bloc.dart';

abstract class AddEmployeeEvent {}

class AddEmployeeFieldChanged extends AddEmployeeEvent {
  final Employee Function(Employee) update;
  AddEmployeeFieldChanged(this.update);
}

class AddEmployeeDOBChanged extends AddEmployeeEvent {
  final DateTime dob;
  AddEmployeeDOBChanged(this.dob);
}

class AddEmployeeDOJChanged extends AddEmployeeEvent {
  final DateTime doj;
  AddEmployeeDOJChanged(this.doj);
}

class AddEmployeeSubmitted extends AddEmployeeEvent {}

class AddEmployeeReset extends AddEmployeeEvent {}

class LoadEmployeeForEdit extends AddEmployeeEvent {
  final int empCode;
  LoadEmployeeForEdit(this.empCode);
}
