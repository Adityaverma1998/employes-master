import 'package:employes_master/core/helper/formate_salary.dart';
import 'package:employes_master/core/routes/routes.dart';
import 'package:employes_master/core/widgets/common/primary_layout.dart';
import 'package:employes_master/presentation/auth/bloc/auth_bloc.dart';
import 'package:employes_master/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      title: "Dashboard",
      showBackButton: false,
      appBarBottom: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: _buildGreeting(),
      ),
      onLogout: () {
        context.read<AuthBloc>().add(LogoutEvent());
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),

          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUnauthenticated) {
                context.go(AppRoutes.login);
              }

              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],

        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadHomeDataEvent());
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Greeting

                    /// 🔹 Dashboard Cards
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.2,
                      children: [
                        _buildCard(
                          title: "Total Employees",
                          value: state.totalEmployees.toString(),
                          icon: Icons.people,
                          color: Colors.blue,
                        ),
                        _buildCard(
                          title: "Joined This Month",
                          value: state.currentMonthJoined.toString(),
                          icon: Icons.calendar_month,
                          color: Colors.green,
                        ),
                        _buildCard(
                          title: "Monthly Payroll",
                          value: FormateSalary.formatRupee(
                            state.monthlyPayroll,
                          ),
                          icon: Icons.currency_rupee,
                          color: Colors.orange,
                        ),
                        _buildCard(
                          title: "Today's Birthdays",
                          value: state.todayBirthdays.length.toString(),
                          icon: Icons.cake,
                          color: Colors.pink,
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// 🎂 Birthday Section
                    if (state.todayBirthdays.isNotEmpty) ...[
                      Text(
                        "🎂 Today's Birthdays",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.todayBirthdays.length,
                        itemBuilder: (context, index) {
                          final emp = state.todayBirthdays[index];

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.pink.shade100,
                                child: const Icon(Icons.cake),
                              ),
                              title: Text(emp.empName),
                              subtitle: Text(emp.mobile),
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.cake_outlined,
                              size: 60.w,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "No birthdays today 🎉",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return BlocSelector<HomeBloc, HomeState, String>(
      selector: (state) => state.greeting,
      builder: (context, greeting) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "👋 $greeting",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }

  ///  Reusable Card Widget
  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28.w),
          const Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
