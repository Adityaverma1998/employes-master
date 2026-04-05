import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/usecase/employee/add_employee_usecase.dart';
import 'package:employes_master/domain/usecase/employee/get_employee_by_id.dart';
import 'package:employes_master/domain/usecase/employee/update_employee_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final AddEmployeeUseCase addEmployee;
  final UpdateEmployeeUseCase updateEmployee;
  final GetEmployeeByIdUseCase getEmployeeById;

  AddEmployeeBloc({
    required this.addEmployee,
    required this.updateEmployee,
    required this.getEmployeeById,
  }) : super(AddEmployeeState.initial()) {
    on<LoadEmployeeForEdit>(_onLoadForEdit);
    on<AddEmployeeFieldChanged>(_onFieldChanged);
    on<AddEmployeeDOBChanged>(_onDOBChanged);
    on<AddEmployeeDOJChanged>(_onDOJChanged);
    on<AddEmployeeSubmitted>(_onSubmit);
    on<AddEmployeeReset>(_onReset);
  }

  // ─────────────────────────────────────────────
  // 🔹 Load & prefill for edit
  // ─────────────────────────────────────────────
  Future<void> _onLoadForEdit(
    LoadEmployeeForEdit e,
    Emitter<AddEmployeeState> emit,
  ) async {
    emit(state.copyWith(isLoadingEmployee: true));

    final result = await getEmployeeById(e.empCode);

    result.fold(
      (f) => emit(
        state.copyWith(isLoadingEmployee: false, submitError: f.message),
      ),
      (employee) => emit(
        state.copyWith(
          isLoadingEmployee: false,
          form: employee, // 🔹 prefill entire form from entity
          mode: AddEmployeeMode.edit,
          errors: const {}, // 🔹 no errors on prefill
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // 🔹 Field / Date changes
  // ─────────────────────────────────────────────
  void _onFieldChanged(
    AddEmployeeFieldChanged e,
    Emitter<AddEmployeeState> emit,
  ) {
    final updated = e.update(state.form);
    emit(state.copyWith(form: updated, errors: _validate(updated)));
  }

  void _onDOBChanged(AddEmployeeDOBChanged e, Emitter<AddEmployeeState> emit) {
    final updated = state.form.copyWith(dob: AddEmployeeState.fmtDate(e.dob));
    emit(state.copyWith(form: updated, errors: _validate(updated)));
  }

  void _onDOJChanged(AddEmployeeDOJChanged e, Emitter<AddEmployeeState> emit) {
    final updated = state.form.copyWith(doj: AddEmployeeState.fmtDate(e.doj));
    emit(state.copyWith(form: updated, errors: _validate(updated)));
  }

  // ─────────────────────────────────────────────
  // 🔹 Submit — routes to add or update
  // ─────────────────────────────────────────────
  Future<void> _onSubmit(
    AddEmployeeSubmitted e,
    Emitter<AddEmployeeState> emit,
  ) async {
    final errors = _validate(state.form);
    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearSubmitError: true));

    final result = state.isEditMode
        ? await updateEmployee(state.form)
        : await addEmployee(state.form);

    result.fold(
      (f) => emit(state.copyWith(isSubmitting: false, submitError: f.message)),
      (_) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
    );
  }

  // ─────────────────────────────────────────────
  // 🔹 Reset
  // ─────────────────────────────────────────────
  void _onReset(AddEmployeeReset e, Emitter<AddEmployeeState> emit) {
    emit(AddEmployeeState.initial());
  }

  // ─────────────────────────────────────────────
  // 🔹 Validation
  // ─────────────────────────────────────────────
  Map<String, String> _validate(Employee e) {
    final err = <String, String>{};
    if (e.empName.trim().isEmpty) err['name'] = "Name is required";
    if (e.mobile.trim().isEmpty) {
      err['mobile'] = "Mobile is required";
    } else if (e.mobile.trim().length != 10) {
      err['mobile'] = "Enter valid 10-digit number";
    }
    if (e.dob.isEmpty) err['dob'] = "Please select Date of Birth";
    if (e.doj.isEmpty) err['doj'] = "Please select Date of Joining";
    if (e.salary <= 0) err['salary'] = "Enter valid salary";
    return err;
  }
}
