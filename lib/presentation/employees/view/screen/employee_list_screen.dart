import 'package:employes_master/core/routes/routes.dart';
import 'package:employes_master/core/widgets/common/primary_layout.dart';
import 'package:employes_master/presentation/employees/bloc/employee_bloc.dart';
import 'package:employes_master/presentation/employees/view/widget/employee_card.dart';
import 'package:employes_master/presentation/employees/view/widget/show_delete_employee_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<EmployeeBloc>().add(LoadEmployeesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      title: "Employees",

      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(state.error!, style: TextStyle(fontSize: 14.sp)),
            );
          }

          ///  Decide list (search vs full)
          final employees = _searchController.text.isNotEmpty
              ? state.filteredEmployees
              : state.employees;

          ///  Empty State
          if (employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _searchController.text.isNotEmpty
                        ? "No results found"
                        : "No employees found",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 12.h),
                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.addEmployee);
                    },
                    icon: Icon(Icons.add_circle_outline, size: 60.r),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EmployeeBloc>().add(LoadEmployeesEvent());
            },
            child: Column(
              children: [
                ///  Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      context.read<EmployeeBloc>().add(
                        SearchEmployeeEvent(value),
                      );
                    },
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: "Search employee...",
                      hintStyle: TextStyle(fontSize: 14.sp),
                      prefixIcon: Icon(Icons.search, size: 20.r),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),

                ///  Add Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push(AppRoutes.addEmployee);
                      },
                      icon: Icon(Icons.add, size: 18.r),
                      label: Text(
                        "Add Employee",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                /// Employee List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: EmployeeCard(
                          employee: employee,

                          onEdit: () {
                            context.pushNamed(
                              AppRoutes.addEmployee,
                              queryParameters: {
                                'employeeId': "${employee.empCode}",
                              },
                            );
                          },

                          onDelete: () {
                            showDeleteEmployeeSheet(
                              context: context,
                              employeeName: employee.empName,
                              onConfirm: () {
                                context.read<EmployeeBloc>().add(
                                  DeleteEmployeeEvent(employee),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
