import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/usecase/employee/get_employee_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployeesUseCase getEmployees;

  EmployeeBloc(this.getEmployees) : super(const EmployeeState()) {
    on<LoadEmployeesEvent>(_onLoad);
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
}
