import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showDeleteEmployeeSheet({
  required BuildContext context,
  required String employeeName,
  required VoidCallback onConfirm,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 Drag Handle
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            /// 🔹 Title
            Text(
              "Delete Employee",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.h),

            /// 🔹 Message
            Text(
              "Are you sure you want to delete $employeeName?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Buttons
            Row(
              children: [
                /// Cancel
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text("Cancel", style: TextStyle(fontSize: 13.sp)),
                  ),
                ),

                SizedBox(width: 10.w),

                /// Delete
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text("Delete", style: TextStyle(fontSize: 13.sp)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
