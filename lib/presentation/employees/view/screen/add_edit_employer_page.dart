import 'package:employes_master/core/widgets/common/primary_layout.dart';
import 'package:employes_master/presentation/auth/bloc/auth_bloc.dart';
import 'package:employes_master/presentation/employees/bloc/add_employees_bloc/add_employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEmployeeScreen extends StatefulWidget {
  final int? empCode; // 🔹 null = add mode, non-null = edit mode
  const AddEmployeeScreen({super.key, this.empCode});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  // 🔹 Controllers only needed to prefill text fields in edit mode
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _salaryController = TextEditingController();
  final _addressController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.empCode != null) {
      context.read<AddEmployeeBloc>().add(LoadEmployeeForEdit(widget.empCode!));
    }
  }

  /// 🔹 Prefill controllers once when edit data loads
  void _prefillControllers(AddEmployeeState state) {
    if (state.isEditMode && !state.isLoadingEmployee) {
      _nameController.text = state.form.empName;
      _mobileController.text = state.form.mobile;
      _salaryController.text = state.form.salary == 0
          ? ''
          : state.form.salary.toStringAsFixed(0);
      _addressController.text = state.form.address ?? '';
      _remarkController.text = state.form.remark ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _salaryController.dispose();
    _addressController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, {required bool isDOB}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isDOB ? DateTime(2000) : now,
      firstDate: isDOB ? DateTime(1960) : DateTime(2000),
      lastDate: now,
    );
    if (picked != null && context.mounted) {
      context.read<AddEmployeeBloc>().add(
        isDOB ? AddEmployeeDOBChanged(picked) : AddEmployeeDOJChanged(picked),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddEmployeeBloc, AddEmployeeState>(
      /// 🔹 Prefill controllers once when employee loads for edit
      listenWhen: (p, c) => p.isLoadingEmployee && !c.isLoadingEmployee,
      listener: (_, state) => _prefillControllers(state),
      child: PrimaryLayout(
        title: widget.empCode != null ? "Edit Employee" : "Add Employee",
        onLogout: () => context.read<AuthBloc>().add(LogoutEvent()),
        child: MultiBlocListener(
          listeners: [
            BlocListener<AddEmployeeBloc, AddEmployeeState>(
              listenWhen: (p, c) =>
                  p.isSuccess != c.isSuccess || p.submitError != c.submitError,
              listener: (context, state) {
                if (state.submitError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.submitError!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.isEditMode
                            ? "Employee updated successfully ✅"
                            : "Employee added successfully ✅",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<AddEmployeeBloc>().add(AddEmployeeReset());
                  Navigator.pop(context);
                }
              },
            ),
          ],
          child: BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
            builder: (context, state) {
              /// 🔹 Show loader while fetching employee for edit
              if (state.isLoadingEmployee) {
                return const Center(child: CircularProgressIndicator());
              }

              final e = state.errors;
              final f = state.form;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("👤 Personal Information"),
                    SizedBox(height: 12.h),

                    _field(
                      controller: _nameController,
                      label: "Full Name",
                      icon: Icons.person,
                      errorText: e['name'],
                      onChanged: (v) => context.read<AddEmployeeBloc>().add(
                        AddEmployeeFieldChanged(
                          (emp) => emp.copyWith(empName: v),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    _field(
                      controller: _mobileController,
                      label: "Mobile Number",
                      icon: Icons.phone,
                      errorText: e['mobile'],
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (v) => context.read<AddEmployeeBloc>().add(
                        AddEmployeeFieldChanged(
                          (emp) => emp.copyWith(mobile: v),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    _datePicker(
                      label: "Date of Birth",
                      icon: Icons.cake,
                      value: f.dob,
                      errorText: e['dob'],
                      onTap: () => _pickDate(context, isDOB: true),
                    ),
                    SizedBox(height: 12.h),

                    _field(
                      controller: _addressController,
                      label: "Address (optional)",
                      icon: Icons.location_on,
                      maxLines: 3,
                      onChanged: (v) => context.read<AddEmployeeBloc>().add(
                        AddEmployeeFieldChanged(
                          (emp) => emp.copyWith(address: v),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    _field(
                      controller: _remarkController,
                      label: "Remark (optional)",
                      icon: Icons.note,
                      maxLines: 2,
                      onChanged: (v) => context.read<AddEmployeeBloc>().add(
                        AddEmployeeFieldChanged(
                          (emp) => emp.copyWith(remark: v),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),
                    _sectionTitle("💼 Job Information"),
                    SizedBox(height: 12.h),

                    _datePicker(
                      label: "Date of Joining",
                      icon: Icons.calendar_today,
                      value: f.doj,
                      errorText: e['doj'],
                      onTap: () => _pickDate(context, isDOB: false),
                    ),
                    SizedBox(height: 12.h),

                    _field(
                      controller: _salaryController,
                      label: "Monthly Salary (₹)",
                      icon: Icons.currency_rupee,
                      errorText: e['salary'],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (v) => context.read<AddEmployeeBloc>().add(
                        AddEmployeeFieldChanged(
                          (emp) =>
                              emp.copyWith(salary: double.tryParse(v) ?? 0),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () => context.read<AddEmployeeBloc>().add(
                                AddEmployeeSubmitted(),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: Colors.blue.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: state.isSubmitting
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                state.isEditMode
                                    ? "Update Employee"
                                    : "Add Employee",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  );

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ValueChanged<String> onChanged,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        prefixIcon: Icon(icon, color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _datePicker({
    required String label,
    required IconData icon,
    required String value,
    required VoidCallback onTap,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.blue),
                SizedBox(width: 12.w),
                Text(
                  value.isNotEmpty ? value : label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: value.isNotEmpty ? Colors.black : Colors.grey,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 4.h),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
