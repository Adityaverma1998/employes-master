import 'package:employes_master/core/widgets/common/primary_layout.dart';
import 'package:employes_master/presentation/auth/bloc/auth_bloc.dart';
import 'package:employes_master/presentation/employees/bloc/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      title: "Employees",
      onLogout: () {
        context.read<AuthBloc>().add(LogoutEvent());
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          if (state.employees.isEmpty) {
            return const Center(child: Text("No employees found"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EmployeeBloc>().add(LoadEmployeesEvent());
            },
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final employee = state.employees[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(employee.empName[0].toUpperCase()),
                    ),
                    title: Text(employee.empName),
                    subtitle: Text(employee.mobile),
                    trailing: Text("₹${employee.salary.toStringAsFixed(0)}"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
