part of 'employee_bloc.dart';

class EmployeeState {
  final bool isLoading;
  final List<Employee> employees;
  final List<Employee> filteredEmployees;

  final String? error;

  const EmployeeState({
    this.isLoading = false,
    this.employees = const [],

    this.filteredEmployees = const [],
    this.error,
  });

  EmployeeState copyWith({
    bool? isLoading,
    List<Employee>? employees,
    final List<Employee>? filteredEmployees,

    String? error,
  }) {
    return EmployeeState(
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      error: error,
    );
  }
}
