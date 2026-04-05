part of 'employee_bloc.dart';

class EmployeeState {
  final bool isLoading;
  final List<Employee> employees;
  final String? error;

  const EmployeeState({
    this.isLoading = false,
    this.employees = const [],
    this.error,
  });

  EmployeeState copyWith({
    bool? isLoading,
    List<Employee>? employees,
    String? error,
  }) {
    return EmployeeState(
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      error: error,
    );
  }
}
