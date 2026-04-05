import 'package:employes_master/domain/entities/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onDetail;

  const EmployeeCard({
    super.key,
    required this.employee,
    this.onEdit,
    this.onDelete,
    this.onDetail,
  });

  String getInitials(String name) {
    if (name.trim().isEmpty) return "?";
    final parts = name.trim().split(" ");
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 6.r,
            color: Colors.black.withOpacity(0.04),
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row (Avatar + Name + Salary)
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  getInitials(employee.empName),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              /// Name + Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.empName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "ID: ${employee.empCode}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              /// 💰 Salary Highlight
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "₹${employee.salary.toStringAsFixed(0)}",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// 🔹 Middle Info
          Text(
            "📞 ${employee.mobile}",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
          ),

          SizedBox(height: 2.h),

          Text(
            "📅 Joined: ${employee.doj}",
            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
          ),

          SizedBox(height: 10.h),

          /// 🔹 Divider
          Divider(height: 1.h, color: Colors.grey.shade200),

          SizedBox(height: 6.h),

          /// 🔹 Bottom Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionButton(Icons.edit, "Edit", Colors.blue, onEdit),

              _actionButton(Icons.delete, "Delete", Colors.red, onDelete),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Row(
          children: [
            Icon(icon, size: 16.sp, color: color),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
