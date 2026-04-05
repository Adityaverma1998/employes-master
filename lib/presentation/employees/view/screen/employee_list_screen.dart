import 'package:employes_master/core/routes/routes.dart';
import 'package:employes_master/core/widgets/common/primary_layout.dart';
import 'package:employes_master/presentation/employees/bloc/employee_bloc.dart';
import 'package:employes_master/presentation/employees/view/widget/employee_card.dart';
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
  @override
  void initState() {
    super.initState();

    /// ✅ Trigger event on screen load
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
          /// 🔹 Loading
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// 🔹 Error
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          /// 🔹 Empty State
          if (state.employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No employees found"),
                  const SizedBox(height: 12),
                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.addEmployee);
                    },
                    icon: const Icon(Icons.add_circle_outline, size: 60),
                  ),
                ],
              ),
            );
          }

          /// 🔹 List
          return RefreshIndicator(
            onRefresh: () async {
              context.read<EmployeeBloc>().add(LoadEmployeesEvent());
            },
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(AppRoutes.addEmployee);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Employee"),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.employees.length,
                    itemBuilder: (context, index) {
                      final employee = state.employees[index];

                      return EmployeeCard(
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
                          // context.read<EmployeeBloc>().add(
                          //   DeleteEmployeeEvent(employee),
                        },
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
