import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/usecase/employee/delete_employee_usecase.dart';
import 'package:employes_master/domain/usecase/employee/get_employee_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployeesUseCase getEmployees;
  final DeleteEmployeeUseCase deleteEmployee;

  EmployeeBloc(this.getEmployees, this.deleteEmployee)
    : super(const EmployeeState()) {
    on<LoadEmployeesEvent>(_onLoad);
    on<DeleteEmployeeEvent>(_onDelete);
    on<SearchEmployeeEvent>(_onSearch);
  }

  Future<void> _onLoad(
    LoadEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getEmployees();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (employees) {
        emit(state.copyWith(isLoading: false, employees: employees));
      },
    );
  }

  Future<void> _onDelete(
    DeleteEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await deleteEmployee(event.employee);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (_) {
        final updatedList = state.employees
            .where((e) => e.empCode != event.employee.empCode)
            .toList();

        emit(
          state.copyWith(
            isLoading: false,
            employees: updatedList,
            filteredEmployees: updatedList, // keep in sync
          ),
        );
      },
    );
  }

  Future<void> _onSearch(
    SearchEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(filteredEmployees: state.employees));
      return;
    }

    final filtered = state.employees.where((employee) {
      return employee.empName.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(filteredEmployees: filtered));
  }
}
