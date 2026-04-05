part of 'add_employee_bloc.dart';

enum AddEmployeeMode { add, edit }

class AddEmployeeState {
  final Employee form;
  final Map<String, String> errors;
  final bool isSubmitting;
  final bool isSuccess;
  final String? submitError;
  final bool isLoadingEmployee;
  final AddEmployeeMode mode;

  static Employee get _empty => Employee(
    empCode: 0,
    empName: '',
    mobile: '',
    dob: '',
    doj: '',
    salary: 0,
  );

  static String fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/"
      "${d.month.toString().padLeft(2, '0')}/"
      "${d.year}";

  const AddEmployeeState({
    required this.form,
    this.errors = const {},
    this.isSubmitting = false,
    this.isSuccess = false,
    this.submitError,
    this.isLoadingEmployee = false,
    this.mode = AddEmployeeMode.add,
  });

  factory AddEmployeeState.initial() => AddEmployeeState(form: _empty);

  bool get isEditMode => mode == AddEmployeeMode.edit;

  AddEmployeeState copyWith({
    Employee? form,
    Map<String, String>? errors,
    bool? isSubmitting,
    bool? isSuccess,
    String? submitError,
    bool? isLoadingEmployee,
    AddEmployeeMode? mode,
    bool clearSubmitError = false,
  }) {
    return AddEmployeeState(
      form: form ?? this.form,
      errors: errors ?? this.errors,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      submitError: clearSubmitError ? null : submitError ?? this.submitError,
      isLoadingEmployee: isLoadingEmployee ?? this.isLoadingEmployee,
      mode: mode ?? this.mode,
    );
  }
}
