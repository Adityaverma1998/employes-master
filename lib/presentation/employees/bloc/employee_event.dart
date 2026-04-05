part of 'employee_bloc.dart';

abstract class EmployeeEvent {}

class LoadEmployeesEvent extends EmployeeEvent {}

class DeleteEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  DeleteEmployeeEvent(this.employee);
}

class SearchEmployeeEvent extends EmployeeEvent {
  final String query;

  SearchEmployeeEvent(this.query);
}
